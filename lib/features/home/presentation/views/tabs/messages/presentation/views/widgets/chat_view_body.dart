import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../domain/entities/message_entity/message_entity.dart';
import '../../manager/get_messages_view_model/get_messages_view_model.dart';
import '../../manager/get_messages_view_model/get_messages_view_model_states.dart';
import '../../manager/send_message_view_model/send_message_view_model.dart';
import '../../manager/send_message_view_model/send_message_view_model_states.dart';
import 'chat_input_field.dart';
import 'message_bubble.dart';
import '../../../../../../../../../features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';

class ChatViewBody extends StatefulWidget {
  final String currentUserId;
  final String receiverId;
  final String currentUserRole;
  final String receiverUserRole;

  const ChatViewBody({
    super.key,
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserRole,
    required this.receiverUserRole,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _currentlyPlayingUrl = null;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildAttachmentWidget(AttachmentEntity att, bool isCurrentUser, String messageId, {bool isTemporary = false}) {
    final isImage = att.type.startsWith("image/");
    final isPDF = att.type == "application/pdf";
    final isAudio = att.type.startsWith("audio/") || att.type == "application/octet-stream";

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          width: 250,
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Colors.blue.withOpacity(isTemporary ? 0.03 : 0.05)
                : Colors.green.withOpacity(isTemporary ? 0.03 : 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCurrentUser
                  ? Colors.blue.withOpacity(isTemporary ? 0.1 : 0.2)
                  : Colors.green.withOpacity(isTemporary ? 0.1 : 0.2),
              style: isTemporary ? BorderStyle.solid : BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isImage
                      ? Icons.image
                      : isPDF
                      ? Icons.picture_as_pdf
                      : Icons.audiotrack,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: !isAudio
                      ? () {
                    if (isImage) {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              InteractiveViewer(
                                child: Image.network(
                                  att.url,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (isPDF) {
                      launchUrl(Uri.parse(att.url));
                    }
                  }
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        att.name ?? "Attachment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isImage
                            ? "Image"
                            : isPDF
                            ? "PDF Document"
                            : "Audio File",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isAudio)
                IconButton(
                  icon: Icon(
                    _currentlyPlayingUrl == att.url
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.orange,
                    size: 28,
                  ),
                  onPressed: () async {
                    if (_currentlyPlayingUrl == att.url) {
                      await _audioPlayer.pause();
                      setState(() => _currentlyPlayingUrl = null);
                    } else {
                      await _audioPlayer.stop();
                      await _audioPlayer.play(UrlSource(att.url));
                      setState(() => _currentlyPlayingUrl = att.url);
                    }
                  },
                ),
            ],
          ),
        ),
        if (isTemporary)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCurrentUser ? Colors.blue : Colors.green,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _generateMessageKey(MessageEntity msg) {
    return '${msg.id}_${msg.createdAt.millisecondsSinceEpoch}';
  }

  List<Widget> _buildMessageContent(MessageEntity msg, bool isCurrentUser, bool isTemporary) {
    final widgets = <Widget>[];

    // إضافة مؤشر للرسائل المؤقتة
    if (isTemporary) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: isCurrentUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isCurrentUser) const SizedBox(width: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.blue : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Sending...",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCurrentUser) const SizedBox(width: 40),
            ],
          ),
        ),
      );
    }

    // إضافة النصوص
    if (msg.messageType == "text" && (msg.content?.isNotEmpty ?? false)) {
      widgets.add(
        MessageBubble(
          sender: isCurrentUser ? SenderType.admin : SenderType.client,
          message: msg.content ?? "",
          avatarUrl: Assets.assetsImagesAdminAvatar,
          chatWithUsers: true,
          time: "${msg.createdAt.hour}:${msg.createdAt.minute.toString().padLeft(2, '0')}",
        ),
      );
    }

    // إضافة الملفات
    if (msg.attachment != null && msg.attachment!.isNotEmpty) {
      final attachmentWidgets = msg.attachment!
          .map((att) => _buildAttachmentWidget(att, isCurrentUser, msg.id, isTemporary: isTemporary))
          .toList();

      widgets.add(
        Column(
          crossAxisAlignment: isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: attachmentWidgets,
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final vm = GetMessagesViewModel(getIt());
            vm.getMessages(
              senderId: widget.currentUserId,
              receiverId: widget.receiverId,
            );
            vm.subscribeToMessagesStream(
              senderId: widget.currentUserId,
              receiverId: widget.receiverId,
            );
            return vm;
          },
        ),
        BlocProvider(
          create: (_) => getIt<SendMessageViewModel>(),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<SendMessageViewModel, SendMessageViewModelStates>(
                  listener: (context, state) {
                    if (state is SendMessageViewModelStatesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to send message: ${state.failure}'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } else if (state is SendMessageViewModelStatesSuccess) {
                      _scrollToBottom();
                    }
                  },
                ),
                BlocListener<GetMessagesViewModel, GetMessagesViewModelStates>(
                  listener: (context, state) {
                    if (state is GetMessagesViewModelStatesSuccess) {
                      _scrollToBottom();
                    }
                  },
                ),
              ],
              child: BlocBuilder<GetMessagesViewModel, GetMessagesViewModelStates>(
                builder: (context, state) {
                  if (state is GetMessagesViewModelStatesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetMessagesViewModelStatesError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Error loading messages: ${state.failure}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else {
                    final messages = state is GetMessagesViewModelStatesSuccess
                        ? state.messages
                        : [];

                    final tempMessages = context.select<SendMessageViewModel, List<MessageEntity>>(
                          (vm) => vm.temporaryMessages,
                    );

                    final allMessages = [...messages, ...tempMessages];
                    allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

                    if (allMessages.isEmpty) {
                      return const Center(
                        child: Text(
                          "No messages yet",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: allMessages.length,
                      itemBuilder: (context, index) {
                        final msg = allMessages[index];
                        final isCurrentUser = msg.senderId == widget.currentUserId;
                        final isTemporary = tempMessages.any((m) => m.id == msg.id);

                        return Container(
                          key: ValueKey(_generateMessageKey(msg)),
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: _buildMessageContent(msg, isCurrentUser, isTemporary),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          ChatInputField(
            orderId: null,
            currentUserId: widget.currentUserId,
            receiverId: widget.receiverId,
            currentUserRole: widget.currentUserRole,
            receiverUserRole: widget.receiverUserRole,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

}