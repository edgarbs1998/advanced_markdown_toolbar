// TODO Avoid using dynamic types and prefer generics instead.
abstract class ToolbarItemFormatTemplate {
  Future<dynamic> Function(String text, int? index) get preFormatTemplate;
  String Function(dynamic) get template;
}
