import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:advanced_markdown_toolbar/src/widgets/toolbar.dart';
import 'package:flutter/widgets.dart';

class AdvancedMarkdownToolbar extends StatelessWidget {
  const AdvancedMarkdownToolbar({
    required this.controller,
    required this.focusNode,
    super.key,
    this.items,
    this.showTooltips = true,
    this.iconColor,
    this.surfaceColor,
    this.menuItemColor,
    this.iconPadding = const EdgeInsets.all(8),
    this.iconSize,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.itemBuilder,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ToolbarItems? items;
  final bool showTooltips;
  final Color? iconColor;
  final Color? menuItemColor;
  final Color? surfaceColor;
  final EdgeInsets iconPadding;
  final double? iconSize;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final Widget Function({
    IconData icon,
    bool dropdown,
    String? tooltip,
    List<ToolbarDropdownItem>? dropdownItems,
    VoidCallback? onPressed,
    ValueChanged<ToolbarDropdownItem>? onMenuItemSelected,
  })? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      controller: controller,
      focusNode: focusNode,
      items: items,
      showTooltips: showTooltips,
      iconColor: iconColor,
      surfaceColor: surfaceColor,
      menuItemColor: menuItemColor,
      iconPadding: iconPadding,
      iconSize: iconSize,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      itemBuilder: itemBuilder,
    );
  }
}
