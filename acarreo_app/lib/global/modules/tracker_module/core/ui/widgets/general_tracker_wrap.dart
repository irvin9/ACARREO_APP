import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class GeneralTrackerWrap extends StatelessWidget {
  const GeneralTrackerWrap({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 5,
    this.onContinue,
    this.mainButtonText,
    this.showMainButton = true,
    this.child = const RouterOutlet(),
    this.children = const [],
    this.actions = const [],
    this.disableToBack = false,
    this.showStepper = true,
  });

  factory GeneralTrackerWrap.withRouterOutlet({
    currentStep = 1,
    totalSteps = 5,
    onContinue,
    mainButtonText,
    showMainButton = true,
    child = const RouterOutlet(),
    children = const [],
    actions = const [],
    disableToBack = false,
    showStepper = true,
  }) {
    return GeneralTrackerWrap(
      currentStep: currentStep,
      totalSteps: totalSteps,
      onContinue: onContinue,
      mainButtonText: mainButtonText,
      showMainButton: showMainButton,
      child: child,
      children: children,
      actions: actions,
      disableToBack: disableToBack,
      showStepper: showStepper,
    );
  }

  final void Function()? onContinue;
  final List<GeneralButton> actions;
  final Widget child;
  final List<Widget> children;
  final int? currentStep;
  final bool disableToBack;
  final String? mainButtonText;
  final bool showMainButton;
  final bool showStepper;
  final int? totalSteps;

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
                if (children.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [...children],
                      ),
                    ),
                  )
                else
                  Expanded(child: child)
              ],
            ),
          ),
          Visibility(
            visible:
                showMainButton && MediaQuery.of(context).viewInsets.bottom == 0,
            child: Column(
              children: [
                GeneralButton(
                  vertical: actions.isEmpty ? 16.0 : 0.0,
                  horizontal: 16.0,
                  buttonText: mainButtonText ?? 'Continuar',
                  buttonElevation: 2.0,
                  textColor: Colors.black87,
                  onPressed: onContinue,
                ),
                ...actions
              ],
            ),
          ),
        ],
      ),
    ).setScaffoldWithAppBar(disableToBack: disableToBack);
  }
}
