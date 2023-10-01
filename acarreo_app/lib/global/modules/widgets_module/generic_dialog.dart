import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final Widget child;
  final bool dismissible;
  const GenericDialog(
      {super.key, required this.child, this.dismissible = false});

  static Future<void> show({
    required BuildContext context,
    Key? key,
    required Widget child,
    bool dismissible = false,
  }) async =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: dismissible,
        builder: (_) => GenericDialog(
          key: key,
          dismissible: dismissible,
          child: child,
        ),
      );

  static void hide(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissible,
      child: child,
    );
  }
}
