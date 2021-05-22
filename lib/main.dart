import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sms/classes/app_localization.dart';
import 'package:sms/hiveTest/home.dart';
import 'package:sms/hiveTest/notes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_prov;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_prov.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesAdapter());
  runApp(new MaterialApp(
    supportedLocales: [Locale('en', ''), Locale('ur', '')],
    localizationsDelegates: [
      ApplicationLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var loc in supportedLocales) {
        if (loc.languageCode == locale.languageCode) {
          return loc;
        }
      }
      return supportedLocales.first;
    },
    home: homev(),
  ));
}
