import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color hexToColor() => Color(int.parse("0xFF$this"));
  int hexToInt() => int.parse("0xFF$this");
}

extension PaddingExtension on Widget {
  Padding paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Padding paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}

// extension BooleanExtension on bool {
//   void toggle() =>  !this ;
// }
