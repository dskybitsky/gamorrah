import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';

class LabeledInput extends StatelessWidget {
  LabeledInput({
    required this.label,
    required this.child,
    this.expanded = true
  });

  final Widget label;
  final Widget child;
  final bool expanded;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: label),
        HSpacer(),
        expanded ? Expanded(
          flex: 3,
          child: child,
        ) : child,
      ],
    );
  }
}