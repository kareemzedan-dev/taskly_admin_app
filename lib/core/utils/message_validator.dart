class MessageValidator {
  static final RegExp forbiddenContent = RegExp(
    r'(\+?\d{8,})|((?:https?:\/\/)?(?:www\.)?(?:facebook|wa|whatsapp|t\.me)\/[^\s]+)',
    caseSensitive: false,
  );

  /// Returns true if the message content contains forbidden content
  static bool hasForbiddenContent(String? content) {
    if (content == null || content.isEmpty) return false;
    return forbiddenContent.hasMatch(content);
  }
}
