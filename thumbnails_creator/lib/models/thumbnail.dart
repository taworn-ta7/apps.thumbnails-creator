enum ErrorEnumType {
  cantOpenImage,
  cantSaveImage,
  alreadyExists,
}

/// Thumbnail building item
class Thumbnail {
  /// Source file to read
  String source;

  /// Source file name
  String sourceName;

  /// Source file size
  int sourceSize;

  /// Target file to write
  String? target;

  /// Result after processing
  bool? ok;

  /// Error message, if not ok
  ErrorEnumType? error;

  /// Constructor
  Thumbnail(
    this.source,
    this.sourceName,
    this.sourceSize,
  );
}
