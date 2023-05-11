class ItemImage {
  const ItemImage({
    required this.uri,
    this.alt,
    this.title,
  });

  final String uri;
  final String? alt;
  final String? title;
}
