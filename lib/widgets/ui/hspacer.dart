import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

class HSpacer extends StatelessWidget {
  HSpacer({
    this.size = SpaceSize.m,
  });

  final SpaceSize size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size.value);
  }
}