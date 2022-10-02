import 'dart:io';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import './i18n/strings.g.dart';
import './services/localization.dart';
import './app.dart';

/// Main program.
void main() async {
  // initializes loggings
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    // ignore: avoid_print
    (record) => print(
      "${record.time} ${record.level.name.padRight(7)} ${record.loggerName.padRight(12).characters.take(12)} ${record.message}",
    ),
  );

  // initializes localization
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  LocaleSettings.setLocaleRaw(Localization.instance().current.languageCode);

  // set window title and size
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(t.app);
    setWindowMinSize(const Size(400, 600));
    setWindowMaxSize(const Size(800, 1000));
  }

  // run app
  runApp(TranslationProvider(child: const App()));
}
