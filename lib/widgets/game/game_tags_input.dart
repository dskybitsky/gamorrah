import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

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
    _newTagController = TextEditingController(text: 'new');
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: _value,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value.toSet());
        }
        setState(() {
          _value = value;
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
      trailingBuilder: (state) {
        return Row(children: [
          SizedBox(width: 100, child: TextField(
            controller: _newTagController,
          )),
          HSpacer(),
          IconButton(
            tooltip: 'Add Choice',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => setState(
              () {
                _tags.add(_newTagController.text);
                _newTagController.text = '';
              },
            ),
          )
        ]);
      },
    );
  }
}