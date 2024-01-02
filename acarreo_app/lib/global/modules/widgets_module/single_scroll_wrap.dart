import 'package:flutter/material.dart';

class SingleScrollWrap extends StatelessWidget {
  final List<Widget> children;
  final bool isExpanded;
  const SingleScrollWrap({
    super.key,
    required this.children,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }
}
