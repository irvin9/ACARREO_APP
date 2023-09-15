import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/dots_progress_bar.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class GeneralTrackerScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  final void Function()? onContinue;
  final List<Widget> children;

  const GeneralTrackerScreen({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 4,
    this.onContinue,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      padding:
          const EdgeInsets.only(top: 24.0, bottom: 12.0, right: 24, left: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                DotsProgressBar(currentStep: currentStep!, steps: totalSteps!),
                const SizedBox(height: 24.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [...children],
                    ),
                  ),
                )
              ],
            ),
          ),
          GeneralButton(
            vertical: 16.0,
            horizontal: 16.0,
            buttonText: 'Continuar',
            buttonElevation: 2.0,
            textColor: Colors.black87,
            onPressed: onContinue,
          )
        ],
      ),
    ).setScaffoldWithAppBar();
  }
}
