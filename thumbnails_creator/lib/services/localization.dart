import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';
import '../app.dart';

/// Localization service singleton class.
class Localization {
  static Localization? _instance;

  static Localization instance() {
    _instance ??= Localization();
    return _instance!;
  }

  // ----------------------------------------------------------------------

  static final log = Logger('Localization');

  /// Constructor.
  Localization();

  /// Supported locale list.
  final list = const [
    Locale('en'),
    Locale('th'),
  ];

  /// Current locale.
  Locale get current => list[_index];
  int _index = 0;

  /// Changes current locale.
  void change(BuildContext context, String locale) {
    late int i;
    switch (locale) {
      case 'th':
        i = 1;
        break;

      case 'en':
      case '':
      default:
        i = 0;
        break;
    }

    if (_index != i) {
      _index = i;
      log.info("change locale to $locale");
      LocaleSettings.setLocaleRaw(locale);
      App.refresh(context);
    }
  }
}
