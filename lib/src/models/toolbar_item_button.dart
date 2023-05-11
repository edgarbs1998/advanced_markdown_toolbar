import 'package:advanced_markdown_toolbar/src/models/models.dart';

abstract class ToolbarItemButton extends ToolbarItem {
  const ToolbarItemButton({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    super.tooltip,
    super.newLine,
  });
}
