import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/dots_progress_bar.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class GeneralTrackerWrap extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  final void Function()? onContinue;
  final bool showMainButton;
  final List<Widget> children;
  final bool disableToBack;
  final String? mainButtonText;
  final bool showStepper;

  const GeneralTrackerWrap({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 4,
    this.onContinue,
    this.mainButtonText,
    this.showMainButton = true,
    required this.children,
    this.disableToBack = false,
    this.showStepper = true,
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
                Visibility(
                  visible: showStepper,
                  child: DotsProgressBar(
                          currentStep: currentStep!, steps: totalSteps!)
                      .withPaddingSymmetric(
                    vertical: 12.0,
                    horizontal: 0.0,
                  ),
                ),
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
          Visibility(
            visible:
                showMainButton && MediaQuery.of(context).viewInsets.bottom == 0,
            child: GeneralButton(
              vertical: 16.0,
              horizontal: 16.0,
              buttonText: mainButtonText ?? 'Continuar',
              buttonElevation: 2.0,
              textColor: Colors.black87,
              onPressed: onContinue,
            ),
          ),
        ],
      ),
    ).setScaffoldWithAppBar(disableToBack: disableToBack);
  }
}
