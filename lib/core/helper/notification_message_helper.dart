class NotificationMessageHelper {
  static Map<String, String> buildUserStatusNotification({
    required String role,
    String? status,
    bool? isVerified,
  }) {
    String title = "تحديث حالة الحساب";
    String body = "";

    // ✅ حالة التحقق (Freelancer فقط)
    if (isVerified != null && role == "freelancer") {
      if (isVerified) {
        title = "تم التحقق من حسابك";
        body =
        "🎉 تهانينا! تم التحقق من حسابك بنجاح، يمكنك الآن استقبال الطلبات والعمل بحرية على المنصة.";
      } else {
        title = "إلغاء التحقق من الحساب";
        body =
        "تم إلغاء التحقق من حسابك. يرجى التواصل مع فريق الدعم لمعرفة التفاصيل والخطوات التالية.";
      }

      return {"title": title, "body": body};
    }

    // ✅ الحالات العامة
    if (status != null) {
      final arabicStatus = _statusToArabic(status);
      body = "تم تحديث حالتك إلى: $arabicStatus.";

      switch (status.toLowerCase()) {
        case "active":
          body += "\nيمكنك الآن استخدام جميع مزايا التطبيق بشكل طبيعي ✅";
          break;
        case "deactivate":
          body += "\nتم إيقاف حسابك مؤقتًا. يرجى التواصل مع الدعم لمزيد من التفاصيل ⚠️";
          break;
        case "pending":
          body += "\nطلبك قيد المراجعة، وسنقوم بإبلاغك فور اكتمال التحقق ⏳";
          break;
        case "suspended":
          body += "\nتم تعليق حسابك بسبب مخالفة الشروط. يرجى مراجعة فريق الدعم ❗";
          break;
        case "banned":
          body += "\nتم حظر حسابك نهائيًا بسبب تكرار المخالفات 🚫";
          break;
      }
    } else {
      body = "تم تحديث بيانات حسابك بنجاح.";
    }

    return {"title": title, "body": body};
  }

  static String _statusToArabic(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return "نشط";
      case "deactivate":
        return "غير نشط";
      case "pending":
        return "قيد المراجعة";
      case "suspended":
        return "معلق";
      case "banned":
        return "محظور";
      default:
        return "غير محدد";
    }
  }
}
