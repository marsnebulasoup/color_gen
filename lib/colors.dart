import 'dart:math';
import 'package:flutter/material.dart';

const double goldenRatio = 0.618033988749895;

class RandomColorGenerator {
  double _hue = Random.secure().nextDouble() * 360;
  double _saturation = Random.secure().nextDouble();
  double _value = Random.secure().nextDouble();

  RandomColorGenerator();

  HSVColor newColor() {
    // ↓ this allows the hues to be spaced out so colors aren't repeated.
    _hue = ((Random.secure().nextDouble() + goldenRatio) % 1) *
        360; // % 1 to prevent overflow.
    _saturation = Random.secure().nextDouble();
    _value = Random.secure().nextDouble();

    HSVColor hsvColor = HSVColor.fromAHSV(
      1.0,
      _hue,
      _saturation,
      _value,
    );

    return hsvColor;
  }
}
