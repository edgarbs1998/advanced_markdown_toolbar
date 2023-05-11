class ItemLink {
  const ItemLink({
    required this.text,
    required this.href,
    this.title,
  });

  final String text;
  final String href;
  final String? title;
}
