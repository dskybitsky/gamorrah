import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GameHowLongToBeatInput extends StatelessWidget {
  const GameHowLongToBeatInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GameHowLongToBeat value;
  final void Function(GameHowLongToBeat)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(t.ui.gameHowLongToBeatControl.headerLabel),
      subtitle: _buildSubtitle(),
      children: [
        VSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: TextFormField(
              initialValue: value.story?.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(this.value.copyWith(
                    story: Optional(double.tryParse(value))
                  ));
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.story,
              ),
            )),
            HSpacer(),
            Flexible(child: TextFormField(
              initialValue: value.storySides?.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(this.value.copyWith(
                    storySides: Optional(double.tryParse(value))
                  ));
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.storySides,
              ),
            )),
            HSpacer(),
            Flexible(child: TextFormField(
              initialValue: value.completionist?.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(this.value.copyWith(
                    completionist: Optional(double.tryParse(value))
                  ));
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.completionist,
              ),
            )),
          ],
        ),
        VSpacer(),
      ],
    );
  }

  Widget _buildSubtitle() {
    final List<Widget> widgets = [];

    if (value.story != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storyLabel(count: value.story!)));
    }
    
    if (value.storySides != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storySidesLabel(count: value.storySides!)));
    }

    if (value.completionist != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.completionistLabel(count: value.completionist!)));
    }

    if (widgets.isEmpty) {
      widgets.add(Text(t.ui.general.noText));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets
    );
  }
}