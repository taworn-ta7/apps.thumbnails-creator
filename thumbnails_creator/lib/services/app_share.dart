import 'dart:io';
import 'package:logging/logging.dart';
import '../models/thumbnail.dart';

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
  AppShare() {
    dir = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        '';
    log.info("home directory: $dir");
    clear();
  }

  // ----------------------------------------------------------------------

  /// Clears data to reset.
  void clear() {
    images.clear();
  }

  // ----------------------------------------------------------------------

  static const defaultFileOutput = '%F-thumb%N';

  /// Image files.
  final images = <Thumbnail>[];

  /// Directory usage: false = same as source, true = choose directory.
  bool asDir = false;

  /// Directory name, if asDir = true.
  String dir = '';

  /// File pattern.
  String filePattern = defaultFileOutput;

  /// Sizing method: false = %, true = fix width/height.
  bool asSize = false;

  /// Width, can be % or fix
  int width = 0;

  /// Height, can be % or fix
  int height = 0;
}
