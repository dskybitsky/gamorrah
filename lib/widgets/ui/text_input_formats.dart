import 'package:flutter/services.dart';

class TestInputFormats {
  static final TextInputFormatter hoursFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d+\.?\d*')
  );
}