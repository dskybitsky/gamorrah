import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';

class GamePlatformsInput extends StatelessWidget {
  const GamePlatformsInput({
    super.key,
    required this.value,
    this.onChanged,
    this.emptyState
  });

  final Set<GamePlatform> value;
  final void Function(Set<GamePlatform>)? onChanged;
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: _getHeader(context),
      content:
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: GamePlatform.values
                .map(
                  (e) => Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                    child: Checkbox(
                      checked: value.contains(e),
                      onChanged: (selected) {
                        if (onChanged != null) {
                          final newValue = value;
                        
                          if (selected == true) { 
                            newValue.add(e);
                          } else {
                            newValue.remove(e);
                          }

                          onChanged!(newValue);
                        }
                      },
                      content: Text(e.title),
                    ),
                  ),
                )
                .toList(),
            ),
      ]),
    );
  }

  Widget _getHeader(BuildContext context) {
    if (value.isEmpty && emptyState != null) {
      return emptyState!;
    }

    return Wrap(
      children: value
        .map((e) => Padding(
          padding: EdgeInsets.only(right: 2),
          child: Text(
            '${e.title}; ',
            style: FluentTheme.of(context).typography.caption
          ),
        )).toList(),
    );
  }
}