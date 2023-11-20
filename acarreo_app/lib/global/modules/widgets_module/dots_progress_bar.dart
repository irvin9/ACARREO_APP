import 'package:flutter/material.dart';

class DotsProgressBar extends StatelessWidget {
  final int steps;
  final int currentStep;

  const DotsProgressBar({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  List<Widget> buildDotProgress() {
    final List<Widget> dots = [];

    for (int i = 0; i < steps; i++) {
      dots.add(
        ActiveIndicator(
          isActive: i <= currentStep - 1,
          isFirst: i == 0,
          isLast: i == steps - 1,
        ),
      );
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buildDotProgress(),
      ),
    );
  }
}

class ActiveIndicator extends StatelessWidget {
  final bool isActive;
  final bool isFirst;
  final bool isLast;

  const ActiveIndicator({
    super.key,
    required this.isActive,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: !isFirst,
          child: Container(
            width: 32.0,
            height: 1.0,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: isActive
                      ? const Color(0xFF384596) // const Color(0xFF007AFF)
                      : const Color(0xFFB8B8C3),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 12,
            height: 12,
            decoration: ShapeDecoration(
              color: isActive ? const Color(0xFF384596) : Colors.white,
              shape: isActive
                  ? const OvalBorder()
                  : const OvalBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFB8B8C3),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
