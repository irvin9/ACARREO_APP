import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({
    super.key,
    this.iconSize = 24.0,
    this.fontSize = 24.0,
    this.height = 40.0,
    this.iconColor = Colors.black87,
    this.maxValue = 3,
    this.minValue = 1,
    required this.onPressed,
  });

  final Color iconColor;
  final double fontSize;
  final double iconSize;
  final double height;
  final int minValue;
  final int maxValue;
  final void Function(int) onPressed;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int counter = 1;

  void incrementCounter() {
    setState(() {
      if (counter >= widget.maxValue) return;
      counter++;
      widget.onPressed(counter);
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter <= widget.minValue) return;
      counter--;
      widget.onPressed(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: widget.iconSize,
            color: widget.iconColor,
            icon: const Icon(Icons.remove),
            onPressed: decrementCounter,
          ),
          const VerticalDivider(),
          const Spacer(),
          Text(
            '$counter',
            style: GoogleFonts.poppins(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const VerticalDivider(),
          IconButton(
            iconSize: widget.iconSize,
            color: widget.iconColor,
            icon: const Icon(Icons.add),
            onPressed: incrementCounter,
          ),
        ],
      ),
    );
  }
}
