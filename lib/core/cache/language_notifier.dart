import 'package:flutter/material.dart';
import 'package:taskly_admin/core/services/language_service.dart';

class LanguageNotifier extends ValueNotifier<Locale> {
  LanguageNotifier(Locale value) : super(value);

  Future<void> changeLanguage(String code) async {
    await LanguageService.changeLanguage(code);
    value = Locale(code); // هيفيد MaterialApp rebuild
  }

  String get currentLanguage => value.languageCode;
}
