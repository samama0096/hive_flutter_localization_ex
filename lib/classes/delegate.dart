import 'dart:async';
import 'package:flutter/material.dart';
import 'app_localization.dart';

class AppLocalizationD extends LocalizationsDelegate<ApplicationLocalizations> {
  const AppLocalizationD();

  @override
  bool isSupported(Locale locale) => ['en', 'ur'].contains(locale.languageCode);

  @override
  Future<ApplicationLocalizations> load(Locale loc) async {
    ApplicationLocalizations apL = ApplicationLocalizations(loc);
    await apL.load();
    return apL;
  }

  @override
  bool shouldReload(AppLocalizationD old) => false;
}
