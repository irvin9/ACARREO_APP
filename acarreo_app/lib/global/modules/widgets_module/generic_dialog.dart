import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final Widget child;
  const GenericDialog({super.key, required this.child});

  static Future<void> show({
    required BuildContext context,
    Key? key,
    required Widget child,
  }) async =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => GenericDialog(
          key: key,
          child: child,
        ),
      );

  static void hide(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: child,
    );
  }
}
