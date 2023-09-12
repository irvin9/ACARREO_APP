import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  final String assetName;
  final double height;
  final double width;

  const LogoApp({
    super.key,
    required this.assetName,
    this.height = 160,
    this.width = 320,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      height: height,
      width: double.infinity,
      child: Center(
        child: Container(
          height: double.infinity,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(assetName),
            ),
          ),
        ),
      ),
    );
  }
}
