import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class GameTagsInput extends StatefulWidget {
  const GameTagsInput({
    super.key,
    required this.value,
    this.tags = const {},
    this.onChanged,
  });

  final Set<String> value;
  final Set<String> tags;
  final void Function(Set<String>)? onChanged;

  @override
  State<GameTagsInput> createState() => _GameTagsInputState();
}

class _GameTagsInputState extends State<GameTagsInput> {
  late List<String> _value;
  late List<String> _tags;
  late TextEditingController _newTagController;

  @override
  void initState() {
    super.initState();

    _value = widget.value.toList();
    _tags = widget.tags.toList();
    _newTagController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
          
          if (widget.onChanged != null) {
            widget.onChanged!(value.toSet());
          }  
        });
      },
      itemCount: _tags.length,
      itemBuilder: (selection, i) => ChoiceChip(
        selected: selection.selected(_tags[i]),
        onSelected: selection.onSelected(_tags[i]),
        label: Text(_tags[i]),
      ),
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
      ),
      leadingBuilder: (state) {
        return TextField(
            controller: _newTagController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gameTagsControl.placeholder,
            ),
            onSubmitted: (value) {
              final normalizedValue = value.toLowerCase();

              if (!_tags.contains(normalizedValue)) {
                setState(() {
                  _tags.add(value);
                });
              }

              _newTagController.clear();
            },
          );
      },
    );
  }
}