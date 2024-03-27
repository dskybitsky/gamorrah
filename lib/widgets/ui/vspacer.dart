import 'package:flutter/material.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

class VSpacer extends StatelessWidget {
  VSpacer({
    this.size = SpaceSize.m,
  });

  final SpaceSize size;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size.value);
  }
}