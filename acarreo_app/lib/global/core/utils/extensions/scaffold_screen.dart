import 'package:flutter/material.dart';

extension ScaffoldScreen on Widget {
  setMainScaffold({GlobalKey<ScaffoldState>? key}) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: this,
      ),
    );
  }
}
