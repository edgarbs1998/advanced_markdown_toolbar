import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/exceptions/exceptions.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/widgets.dart';

class ToolbarFormat {
  ToolbarFormat({
    required this.controller,
    required this.selection,
    required this.formatOption,
    required this.newLine,
    this.character,
    this.placeholder,
    this.preFormatTemplate,
    this.template,
  });

  factory ToolbarFormat.toolbarItemPressed({
    required TextEditingController controller,
    required TextSelection selection,
    required ToolbarItem item,
    ToolbarDropdownItem? dropdownItem,
  }) {
    if (!selection.isValid) {
      final textLength = controller.text.length;
      selection =
          TextSelection(baseOffset: textLength, extentOffset: textLength);
    }

    if (item is ToolbarItemDropdown && dropdownItem != null) {
      return ToolbarFormat(
        controller: controller,
        selection: selection,
        formatOption: item.formatOption,
        newLine: item.newLine,
        character: dropdownItem.character,
        placeholder: dropdownItem.placeholder,
      );
    } else if (item is ToolbarItemButton &&
        item is ToolbarItemFormatCharacter) {
      final itemFormatCharacter = item as ToolbarItemFormatCharacter;

      return ToolbarFormat(
        controller: controller,
        selection: selection,
        formatOption: item.formatOption,
        newLine: item.newLine,
        character: itemFormatCharacter.character,
        placeholder: itemFormatCharacter.placeholder,
      );
    } else if (item is ToolbarItemButton && item is ToolbarItemFormatTemplate) {
      final itemFormatTemplate = item as ToolbarItemFormatTemplate;

      return ToolbarFormat(
        controller: controller,
        selection: selection,
        formatOption: item.formatOption,
        newLine: item.newLine,
        preFormatTemplate: itemFormatTemplate.preFormatTemplate,
        template: itemFormatTemplate.template,
      );
    } else {
      throw ToolbarMissingFormatterException();
    }
  }

  final TextEditingController controller;
  final TextSelection selection;
  final ToolbarFormatOption formatOption;
  final bool newLine;
  final String? character;
  final String? placeholder;
  final Future<dynamic> Function(String text, int? index)? preFormatTemplate;
  final String Function(dynamic)? template;

  late final String selectionText;
  late final String beforeSelectionText;
  late final String afterSelectionText;
  late final List<String> beforeLines;
  late final List<String> selectionLines;
  late final List<String> afterLines;
  late final ToolbarFormatSelectionOption selectionOption;
  late final int selectionBaseOffset;
  late final int selectionExtentOffset;

  Future<void> format() async {
    selectionText = controller.text.substring(selection.start, selection.end);
    beforeSelectionText = controller.text.substring(0, selection.start);
    afterSelectionText =
        controller.text.substring(selection.end, controller.text.length);

    _getSelectionLines();

    switch (formatOption) {
      case ToolbarFormatOption.character:
        _formatTypeCharacter();
        break;
      case ToolbarFormatOption.characterStartEnd:
        _formatTypeCharacterStartEnd();
        break;
      case ToolbarFormatOption.characterStart:
        _formatTypeCharacterStart();
        break;
      case ToolbarFormatOption.characterList:
        _formatCharacterList();
        break;
      case ToolbarFormatOption.template:
        await _formatTypeTemplate();
        break;
      case ToolbarFormatOption.templateList:
        await _formatTypeTemplateList();
        break;
    }

    _applySelection();
  }

  void _formatTypeCharacter() {
    if (selectionLines.any((line) => line == character)) {
      // Remove
      final newLines = selectionLines.toList()
        ..removeWhere((line) => line == character);
      controller.text = [
        ...beforeLines,
        ...newLines,
        ...afterLines,
      ].join('\n');

      // Calculate selection
      selectionBaseOffset = [
        ...beforeLines,
        ...newLines,
      ].join('\n').length;
      selectionExtentOffset = selectionBaseOffset;
    } else {
      // Add
      var newText = character;
      if (newLine) {
        newText = '\n$newText\n';
      }
      controller.text = [
        ...beforeLines,
        newText,
        ...selectionLines,
        ...afterLines,
      ].join('\n');

      // Calculate selection
      selectionBaseOffset = [
        ...beforeLines,
        newText,
      ].join('\n').length;
      selectionExtentOffset = selectionBaseOffset;
    }
  }

  void _formatTypeCharacterStart() {
    var newText = '';
    if (selectionLines.first.isNotEmpty &&
        selectionLines.first.startsWith(character!)) {
      // Remove
      // TODO Remove any character from the dropdown options
      // TODO Replace the character if the option from the dropdown is a different one that the current one
      newText = selectionLines.first.replaceFirst(character!, '');
    } else {
      // Add
      var afterCharacterText = placeholder;
      if (selectionLines.first.isNotEmpty) {
        afterCharacterText = selectionLines.first;
      }
      newText = '$character$afterCharacterText';
      if (newLine) {
        newText = '\n$newText\n';
      }
    }
    controller.text = [
      ...beforeLines,
      newText,
      if (selectionLines.length > 1) ...selectionLines.sublist(1),
      ...afterLines,
    ].join('\n');

    // Calculate selection
    selectionBaseOffset = [
      ...beforeLines,
      newText,
    ].join('\n').length;
    selectionExtentOffset = selectionBaseOffset;
  }

  void _formatTypeCharacterStartEnd() {
    if (newLine) {
      // TODO Handle remove

      // Multi-line options
      controller.text = [
        ...beforeLines,
        '\n$character',
        ...selectionLines,
        '$character\n',
        ...afterLines,
      ].join('\n');

      // Calculate selection
      selectionBaseOffset = [
        ...beforeLines,
        '\n$character',
        ...selectionLines,
        '$character\n',
      ].join('\n').length;
      selectionExtentOffset = selectionBaseOffset;
    } else {
      // Inline options
      final startSelectedText = beforeSelectionText.split('\n').last;
      final midSelectedText = selectionText.split('\n').first;
      final endSelectedText =
          selectionLines.length > 1 ? '' : afterSelectionText.split('\n').first;

      var newText = '';
      if (character!.allMatches(startSelectedText).length.isOdd) {
        if (midSelectedText.isEmpty) {
          // Handle before selection odd number of characters and no selection
          if (!startSelectedText.endsWith(' ') &&
              !endSelectedText.startsWith(' ')) {
            // Start word
            final startPosition = startSelectedText
                .lastIndexOf(' ')
                .clamp(0, startSelectedText.length);
            final beforeTextAfterLastSpace =
                startSelectedText.substring(startPosition);
            if (beforeTextAfterLastSpace.trimLeft().startsWith(character!)) {
              newText +=
                  '${startSelectedText.substring(0, startPosition)}${beforeTextAfterLastSpace.replaceFirst(character!, '')}';
            } else {
              newText +=
                  '${startSelectedText.substring(0, startPosition)}$character$beforeTextAfterLastSpace';
            }

            // End word
            final endPosition =
                endSelectedText.indexOf(' ').clamp(0, endSelectedText.length);
            final afterTextBeforeFirstSpace =
                endSelectedText.substring(0, endPosition + 1);
            if (afterTextBeforeFirstSpace.trimRight().endsWith(character!)) {
              newText +=
                  '${afterTextBeforeFirstSpace.replaceFirst(character!, '')}${endSelectedText.substring(endPosition + 1)}';
            } else {
              newText +=
                  '$afterTextBeforeFirstSpace$character${endSelectedText.substring(endPosition + 1)}';
            }
          } else {
            newText += '$startSelectedText$endSelectedText';
          }
        } else {
          // Handle before selection odd number of characters with selection
          if (startSelectedText.trimRight().endsWith(character!)) {
            final position = startSelectedText
                .lastIndexOf(character!)
                .clamp(0, startSelectedText.length);
            newText += startSelectedText.replaceFirst(character!, '', position);
          } else if (startSelectedText.endsWith(' ')) {
            newText += '${startSelectedText.trimRight()}$character ';
          } else {
            newText += '$startSelectedText$character';
          }
          newText += midSelectedText.replaceAll(character!, '');
          if (character!.allMatches(endSelectedText).length.isOdd) {
            if (endSelectedText.trimLeft().startsWith(character!)) {
              newText += endSelectedText.replaceFirst(character!, '');
            } else if (endSelectedText.startsWith(' ')) {
              newText += ' $character${endSelectedText.trimLeft()}';
            } else {
              newText += '$character$endSelectedText';
            }
          } else {
            newText += endSelectedText;
          }
        }
      } else {
        // Handle before selection even number of characters
        if (midSelectedText.isEmpty) {
          if (!startSelectedText.endsWith(' ') &&
              !endSelectedText.startsWith(' ')) {
            // No selection but the cursor in in the text
            // Start word
            final startPosition = startSelectedText.lastIndexOf(' ');
            newText +=
                '${startSelectedText.substring(0, startPosition + 1)}$character${startSelectedText.substring(startPosition + 1)}';

            // End word
            var endPosition = endSelectedText.indexOf(' ');
            if (endPosition == -1) {
              endPosition = endSelectedText.length;
            }
            newText +=
                '${endSelectedText.substring(0, endPosition)}$character${endSelectedText.substring(endPosition)}';
          } else {
            // No selection and no text in the cursor
            newText +=
                '$startSelectedText$character$placeholder$character$endSelectedText';
          }
        } else {
          newText += startSelectedText;
          if (midSelectedText.startsWith(' ')) {
            newText +=
                ' $character${midSelectedText.trimLeft().replaceAll(character!, '')}';
          } else {
            newText +=
                '$character${midSelectedText.replaceAll(character!, '')}';
          }
          if (character!.allMatches(endSelectedText).length.isEven) {
            if (endSelectedText.startsWith(' ')) {
              newText += '$character ${endSelectedText.trimLeft()}';
            } else {
              newText += '$character$endSelectedText';
            }
          } else {
            newText += endSelectedText;
          }
        }
      }

      final newAfterLines = [
        if (selectionLines.length > 1) ...selectionLines.sublist(1),
        ...afterLines,
      ];
      controller.text = [
        ...beforeLines,
        newText,
        ...newAfterLines,
      ].join('\n');

      // Calculate selection
      selectionBaseOffset =
          [...beforeLines, startSelectedText].join('\n').length;
      selectionExtentOffset = selectionBaseOffset;
    }
  }

  void _formatCharacterList() {
    final newLines = <String>[];
    if (selectionLines.any((line) => line.startsWith(character!))) {
      // Remove
      for (final line in selectionLines) {
        newLines.add(line.replaceFirst(character!, ''));
      }
    } else if (selectionLines.any((line) => line.isNotEmpty)) {
      // Add
      for (final line in selectionLines) {
        if (line.isEmpty) continue;
        newLines.add('$character$line');
      }
      if (newLine) {
        newLines
          ..first = '\n${newLines.first}'
          ..last = '${newLines.last}\n';
      }
    } else {
      // Add placeholder
      newLines.add('$character$placeholder');
      if (newLine) {
        newLines.first = '\n${newLines.first}\n';
      }
    }
    controller.text = [...beforeLines, ...newLines, ...afterLines].join('\n');

    // Calculate selection
    selectionBaseOffset = [...beforeLines, ...newLines].join('\n').length;
    selectionExtentOffset = selectionBaseOffset;
  }

  Future<void> _formatTypeTemplate() async {
    // No remove, only add
    if (newLine) {
      final preTemplate = await preFormatTemplate!(selectionLines.first, 0);
      if (preTemplate == null) return;
      final newLine = '\n${template!(preTemplate)}\n';
      controller.text = [
        ...beforeLines,
        newLine,
        if (selectionLines.length > 1) ...selectionLines.sublist(1),
        ...afterLines,
      ].join('\n');

      // Calculate selection
      selectionBaseOffset = [...beforeLines, newLine].join('\n').length;
      selectionExtentOffset = selectionBaseOffset;
    } else {
      final preTemplate = await preFormatTemplate!(selectionText, 0);
      if (preTemplate == null) return;
      final newText = template!(preTemplate);
      controller.text = '$beforeSelectionText$newText$afterSelectionText';

      // Calculate selection
      selectionBaseOffset = '$beforeSelectionText$newText'.length;
      selectionExtentOffset = selectionBaseOffset;
    }
  }

  Future<void> _formatTypeTemplateList() async {
    // No remove, only add
    final newLines = <String>[];
    if (selectionLines.any((line) => line.isNotEmpty)) {
      for (var i = 0; selectionLines.length > i; i++) {
        final line = selectionLines[i];
        if (line.isEmpty) continue;

        final preTemplate = await preFormatTemplate!(line, i);
        if (preTemplate == null) continue;
        newLines.add(template!(preTemplate));
      }
      if (newLine) {
        newLines
          ..first = '\n${newLines.first}'
          ..last = '${newLines.last}\n';
      }
    } else {
      // Add placeholder
      final preTemplate = await preFormatTemplate!(selectionText, 0);
      if (preTemplate == null) return;
      newLines.add(template!(preTemplate));
      if (newLine) {
        newLines.first = '\n${newLines.first}\n';
      }
    }
    controller.text = [...beforeLines, ...newLines, ...afterLines].join('\n');

    // Calculate selection
    selectionBaseOffset = [...beforeLines, ...newLines].join('\n').length;
    selectionExtentOffset = selectionBaseOffset;
  }

  void _getSelectionLines() {
    final beforeSplitted = beforeSelectionText.split('\n');
    final selectionSplitted = selectionText.split('\n');
    final afterSplitted = afterSelectionText.split('\n');

    beforeLines = beforeSplitted.sublist(0, beforeSplitted.length - 1);
    if (selectionSplitted.length > 1) {
      selectionLines = [
        beforeSplitted.last + selectionSplitted.first,
        ...selectionSplitted.sublist(1, selectionSplitted.length - 1),
        selectionSplitted.last + afterSplitted.first,
      ];
    } else {
      selectionLines = [
        beforeSplitted.last + selectionSplitted.first + afterSplitted.first,
      ];
    }
    afterLines = afterSplitted.length > 1 ? afterSplitted.sublist(1) : [];
  }

  // TODO Improve the way the selections are calcuated
  void _applySelection() {
    final baseOffset = selectionBaseOffset.clamp(0, controller.text.length);
    final extentOffset = selectionExtentOffset.clamp(0, controller.text.length);

    controller.selection = TextSelection(
      baseOffset: baseOffset,
      extentOffset: extentOffset,
    );
  }
}
