import 'package:flutter/material.dart';

enum SpaceSize { 
  xs,
  s,
  m,
  l,
  xl,
  xxl,
  xxxl;

  double get value => switch (this) {
    (SpaceSize.xs) => 4,
    (SpaceSize.s) => 8,
    (SpaceSize.m) => 16,
    (SpaceSize.l) => 24,
    (SpaceSize.xl) => 32,
    (SpaceSize.xxl) => 64,
    (SpaceSize.xxxl) => 96,
  };
}

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