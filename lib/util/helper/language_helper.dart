import 'package:flutter/material.dart';
import 'package:steemit/data/service/language_service.dart';
import 'package:steemit/generated/l10n.dart';

class LanguageHelper {
  static Future<Locale?> getCurrentLocale() async {
    String? currentLanguageKey = await languageService.getLanguageKey();
    if (currentLanguageKey != null) {
      return Locale(currentLanguageKey);
    }
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    for (var locale in systemLocales) {
      if (S.delegate.isSupported(locale)) {
        return locale;
      }
    }
    return null;
  }
}
