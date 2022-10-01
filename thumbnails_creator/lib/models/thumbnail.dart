/// Thumbnail building item
class Thumbnail {
  /// Source file to read
  String source;

  /// Target file to write
  String target;

  /// Result after processing
  bool? ok;

  /// Constructor
  Thumbnail(
    this.source,
    this.target,
  );
}
