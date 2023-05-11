class ToolbarMissingFormatterException implements Exception {
  ToolbarMissingFormatterException({
    this.message = 'There is no formatter for this type of toolbar item.',
  });

  final String message;
}
