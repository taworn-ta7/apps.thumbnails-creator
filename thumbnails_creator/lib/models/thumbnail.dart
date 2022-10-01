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

  /// Constructor
  Thumbnail(
    this.source,
    this.sourceName,
    this.sourceSize,
  );
}
