import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';

class GameTagsChoice extends StatefulWidget {
  const GameTagsChoice({
    super.key,
    required this.value,
    this.tags = const {},
    this.compact = false,
    this.onChanged,
  });

  final Set<String> value;
  final Set<String> tags;
  final bool compact;
  final void Function(Set<String>)? onChanged;

  @override
  State<GameTagsChoice> createState() => _GameTagsChoiceState();
}

class _GameTagsChoiceState extends State<GameTagsChoice> {
  late List<String> _value;
  late List<String> _tags;
  late TextEditingController _newTagController;

  @override
  void initState() {
    super.initState();

    _value = widget.value.toList();
    
    _tags = widget.tags.toList();
    _tags.sort();

    _newTagController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: t.ui.gameTagsControl.title,
        border: OutlineInputBorder(),
      ),
      child: InlineChoice<String>(
        multiple: true,
        clearable: true,
        value: _value,
        onChanged: _onChanged,
        itemCount: _tags.length,
        itemBuilder: (selection, i) => ChoiceChip(
          selected: selection.selected(_tags[i]),
          onSelected: selection.onSelected(_tags[i]),
          label: Text(_tags[i]),
        ),
        listBuilder: widget.compact ? ChoiceList.createScrollable(
          spacing: 10,
          runSpacing: 10,
        ) : ChoiceList.createWrapped(
          spacing: 10,
          runSpacing: 10,
        ),
        trailingBuilder: widget.compact ? null : (state) {
          return TextField(
              controller: _newTagController,
              decoration: InputDecoration(
                labelText: t.ui.gameTagsControl.newTagPlaceholder,
              ),
              onSubmitted: _onSubmitted,
            );
        },
      )
    );
  }

  void _onChanged(List<String> value) {
    setState(() {
      _value = value;
      _widgetOnChanged();
    });
  }

  void _onSubmitted(String value) {
    final normalizedValue = value.toLowerCase();

    setState(() {
      if (!_tags.contains(normalizedValue)) {
        _tags.add(value);
        _tags.sort();
      }
      
      _value.add(value);
    });

    _newTagController.clear();
    
    _widgetOnChanged();
  }

  void _widgetOnChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_value.toSet());
    }
  }
}