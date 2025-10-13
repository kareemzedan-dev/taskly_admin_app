import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/utils/assets_manager.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';
import 'package:taskly_admin/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/message_entity/message_entity.dart';
import 'package:taskly_admin/features/home/domain/entities/user_entity/user_entity.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_messages_view_model/get_messages_view_model.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/messages/presentation/manager/get_messages_view_model/get_messages_view_model_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_states.dart';
import 'package:taskly_admin/features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart';
import 'message_bubble.dart';
import 'order_status_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

class ProjectChatViewBody extends StatefulWidget {
  final String clientId;
  final String freelancerId;
  final double price;
  final String status;

  const ProjectChatViewBody({
    super.key,
    required this.clientId,
    required this.freelancerId,
    required this.price,
    required this.status,
  });

  @override
  State<ProjectChatViewBody> createState() => _ProjectChatViewBodyState();
}

class _ProjectChatViewBodyState extends State<ProjectChatViewBody> {
  final ScrollController _scrollController = ScrollController();

  late final GetUserInfoByIdViewModel clientBloc;
  late final GetUserInfoByIdViewModel freelancerBloc;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl;

  @override
  void initState() {
    super.initState();
    clientBloc = getIt<GetUserInfoByIdViewModel>()..getUserInfoById(widget.clientId);
    freelancerBloc = getIt<GetUserInfoByIdViewModel>()..getUserInfoById(widget.freelancerId);


    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _currentlyPlayingUrl = null;
      });
    });
  }


  void _scrollToLastMessage() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey.shade50, Colors.grey.shade100],
        ),
      ),
      child: Column(
        children: [
          // Order Status Card
          Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: OrderStatusCard(
              price: widget.price,
              status: widget.status,
              onButtonPressed: () {},
            ),
          ),

          // Chat Header
          _buildChatHeader(),

          // Messages List
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: clientBloc),
                  BlocProvider.value(value: freelancerBloc),
                  BlocProvider(
                    create:
                        (_) =>
                            getIt<GetMessagesViewModel>()
                              ..getMessages(
                                senderId: widget.clientId,
                                receiverId: widget.freelancerId,
                              )
                              ..subscribeToMessagesStream(
                                senderId: widget.clientId,
                                receiverId: widget.freelancerId,
                              ),
                  ),
                ],
                child: BlocBuilder<
                  GetMessagesViewModel,
                  GetMessagesViewModelStates
                >(
                  builder: (context, state) {
                    if (state is GetMessagesViewModelStatesLoading) {
                      return _buildLoadingState();
                    } else if (state is GetMessagesViewModelStatesError) {
                      return _buildErrorState(state.failure.message);
                    } else if (state is GetMessagesViewModelStatesSuccess) {
                      final messages = state.messages;
                      if (messages.isEmpty) return _buildEmptyState();

                      return BlocBuilder<
                        GetUserInfoByIdViewModel,
                        GetUserInfoByIdStates
                      >(
                        bloc: clientBloc,
                        builder: (context, clientState) {
                          return BlocBuilder<
                            GetUserInfoByIdViewModel,
                            GetUserInfoByIdStates
                          >(
                            bloc: freelancerBloc,
                            builder: (context, freelancerState) {
                              if (clientState is GetUserInfoByIdSuccess &&
                                  freelancerState is GetUserInfoByIdSuccess) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  _scrollToLastMessage();
                                });

                                return _buildMessagesList(
                                  context,
                                  messages,
                                  clientState,
                                  freelancerState,
                                );
                              }

                              return _buildLoadingState();
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Client Info
          Expanded(
            child: _buildUserInfo(widget.clientId, clientBloc, 'Client'),
          ),

          // VS Separator
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorsManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'VS',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.primary,
              ),
            ),
          ),

          // Freelancer Info
          Expanded(
            child: _buildUserInfo(
              widget.freelancerId,
              freelancerBloc,
              'Freelancer',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(
    String userId,
    GetUserInfoByIdViewModel bloc,
    String role,
  ) {
    return BlocBuilder<GetUserInfoByIdViewModel, GetUserInfoByIdStates>(
      bloc: bloc,
      builder: (context, state) {
        if (state is GetUserInfoByIdSuccess) {
          return Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: role == 'Client' ? Colors.blue : Colors.green,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child:
                      (state.userEntity.profileImage?.isNotEmpty ?? false)
                          ? Image.network(
                            state.userEntity.profileImage!,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Icon(
                                  Icons.person,
                                  size: 20.sp,
                                  color: Colors.grey,
                                ),
                          )
                          : Image.asset(
                            Assets.assetsImagesUsersAvatar,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Icon(
                                  Icons.person,
                                  size: 20.sp,
                                  color: Colors.grey,
                                ),
                          ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userEntity.fullName ?? role,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            role == 'Client'
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: role == 'Client' ? Colors.blue : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: Icon(
                Icons.person,
                size: 20.sp,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 8.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessagesList(
    BuildContext context,
    List<MessageEntity> messages,
    GetUserInfoByIdSuccess clientState,
    GetUserInfoByIdSuccess freelancerState,
  ) {
    return ListView.separated(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      reverse: false,
      itemCount: messages.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isClient = msg.senderId == widget.clientId; // ✅ التصحيح هنا

        final avatarUrl =
            isClient
                ? clientState.userEntity.profileImage
                : freelancerState.userEntity.profileImage;

        final senderName =
            isClient
                ? clientState.userEntity.fullName ?? "Client"
                : freelancerState.userEntity.fullName ?? "Freelancer";

        return Column(
          crossAxisAlignment:
              isClient ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Text Message Bubble
            if (msg.messageType == "text" && (msg.content?.isNotEmpty ?? false))
              Align(
                alignment:
                    isClient ? Alignment.centerRight : Alignment.centerLeft,
                child: MessageBubble(
                  sender: isClient ? SenderType.client : SenderType.freelancer,
                  message: msg.content ?? "",
                  avatarUrl: avatarUrl ?? '',
                  time: DateFormat(
                    "hh:mm a",
                  ).format(msg.createdAt ?? DateTime.now()),
                ),
              ),

            // Attachments
            if (msg.attachment != null && msg.attachment!.isNotEmpty)
              Align(
                alignment:
                    isClient ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment:
                      isClient
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children:
                      msg.attachment!.map((att) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          child: _buildAttachmentWidget(att, isClient),
                        );
                      }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildAttachmentWidget(AttachmentEntity att, bool isClient) {
    final isImage = att.type.startsWith("image/");
    final isPDF = att.type == "application/pdf";
    final isAudio = att.type.startsWith("application/octet-stream");

    return Container(
      width: 250.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:
            isClient
                ? Colors.blue.withOpacity(0.05)
                : Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              isClient
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.green.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // File Icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: isClient ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              isImage
                  ? Icons.image
                  : isPDF
                  ? Icons.picture_as_pdf
                  : Icons.audiotrack,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // File Info
          Expanded(
            child: GestureDetector(
              onTap: !isAudio ? () => _previewAttachment(att) : null,
              // الصور وPDF بس
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    att.name ?? "Attachment",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    isImage
                        ? 'Image'
                        : isPDF
                        ? 'PDF Document'
                        : isAudio
                        ? 'Audio File'
                        : 'File',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // زرار الصوت
          if (isAudio)
            IconButton(
              icon: Icon(
                _currentlyPlayingUrl == att.url
                    ? Icons.pause_circle
                    : Icons.play_circle,
                color: Colors.orange,
                size: 28.sp,
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
    );
  }

  void _previewAttachment(AttachmentEntity att) {
    if (att.type.startsWith("image/")) {
      showDialog(
        context: context,
        builder:
            (_) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(20.w),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(att.url, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: 8.w,
                    right: 8.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      );
    } else if (att.type == "application/pdf") {
      launchUrl(Uri.parse(att.url));
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primary),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading messages...',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'Failed to load messages',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start the conversation by sending a message',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
