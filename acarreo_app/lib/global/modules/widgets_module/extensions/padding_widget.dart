import 'package:flutter/material.dart';

extension AddPadding on Widget {
  withPaddingOnly({
    double top = 8.0,
    double bottom = 8.0,
    double left = 8.0,
    double right = 8.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: this,
    );
  }

  withPaddingSymmetric({
    double vertical = 8.0,
    double horizontal = 8.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }
}
