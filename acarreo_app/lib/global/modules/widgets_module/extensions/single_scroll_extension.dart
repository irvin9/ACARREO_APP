import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

extension SingleScroll on List<Widget> {
  setSingleScroll() {
    return SingleScrollWrap(children: this);
  }
}
