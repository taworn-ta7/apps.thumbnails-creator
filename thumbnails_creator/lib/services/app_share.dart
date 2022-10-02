import 'dart:io';
import 'package:logging/logging.dart';
import '../models/thumbnail.dart';
import 'types.dart';

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
  static const maxRetry = 10;

  /// Image files.
  final images = <Thumbnail>[];

  /// Directory usage.
  DirEnumType dirEnum = DirEnumType.sameAsSource;

  /// Directory name.
  String dir = '';

  /// File pattern.
  String filePattern = defaultFileOutput;

  /// File extension type.
  ExtEnumType extEnum = ExtEnumType.png;

  /// Sizing method.
  SizeEnumType sizeEnum = SizeEnumType.percent;

  /// Width, can be % or fix
  int width = 50;

  /// Height, can be % or fix
  int height = 50;
}
