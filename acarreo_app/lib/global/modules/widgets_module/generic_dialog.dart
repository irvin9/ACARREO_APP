import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final Widget child;
  const GenericDialog({super.key, required this.child});

  static Future<void> show(BuildContext context,
          {Key? key, required Widget child}) async =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => GenericDialog(
          key: key,
          child: child,
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.white,
        // shadowColor: Colors.amber,
        child: Padding(padding: const EdgeInsets.all(24.0), child: child),
      ),
    );
  }
}
