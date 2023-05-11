import 'package:advanced_markdown_toolbar/src/models/models.dart';

abstract class ToolbarItemDropdown extends ToolbarItem {
  const ToolbarItemDropdown({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required this.dropdownItems,
    super.tooltip,
    super.newLine,
  });

  final List<ToolbarDropdownItem> dropdownItems;
}
