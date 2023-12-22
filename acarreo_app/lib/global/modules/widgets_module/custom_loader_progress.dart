import 'package:flutter/material.dart';

class CustomLoaderProgress extends StatelessWidget {
  const CustomLoaderProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: const Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: FittedBox(
            child: CircularProgressIndicator(
              color: Color(0xFF384596),
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}
