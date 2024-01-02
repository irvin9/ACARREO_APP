import 'package:flutter/material.dart';

class SingleScrollWrap extends StatelessWidget {
  final List<Widget> children;
  final bool isExpanded;
  const SingleScrollWrap({
    super.key,
    required this.children,
    this.isExpanded = false,
  });

  factory SingleScrollWrap.withExpanded({
    required List<Widget> children,
  }) {
    return SingleScrollWrap(
      isExpanded: true,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: children,
        ),
      ));
    } else {
      return SingleChildScrollView(
        child: Column(
          children: children,
        ),
      );
    }
  }
}
