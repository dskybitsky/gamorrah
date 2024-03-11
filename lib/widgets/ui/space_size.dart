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