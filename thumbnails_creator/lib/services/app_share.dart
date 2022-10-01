import 'package:logging/logging.dart';
//import 'package:flutter/material.dart';
//import './localization.dart';

/// Application shared service singleton class.
class AppShare {
  static AppShare? _instance;

  static AppShare instance() {
    _instance ??= AppShare();
    return _instance!;
  }

  // ----------------------------------------------------------------------

  static final log = Logger('AppShare');

  /// Constructor.
  AppShare();

  // ----------------------------------------------------------------------

}
