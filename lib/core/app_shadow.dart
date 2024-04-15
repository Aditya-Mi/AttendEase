import 'package:flutter/material.dart';

class MyAppBoxShadow {
  static BoxShadow myCustomBoxShadow(Color color) => const BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 4,
      );
}
