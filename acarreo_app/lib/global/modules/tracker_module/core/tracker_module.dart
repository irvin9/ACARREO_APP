import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/repository/scan_nfc_manager_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/routes/guards/first_location_guard.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/details_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_current_location/preview_current_location_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/read_nfc_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter/material.dart';

class TrackerModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => ScanNFCManagerRepository()),
        Bind.lazySingleton(
          (i) => NfcCubit(i(), i()),
          onDispose: (value) => Modular.get<NfcCubit>().closeScan(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TrackerRoutesModule.formTravelRoute,
          child: ((context, args) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                      value: Modular.get<AcarreoCubit>()..initForm()),
                  BlocProvider.value(value: Modular.get<PrinterCubit>()),
                ],
                child: const TrackerRouterOutlet(),
              )),
          children: [
            ChildRoute(TrackerRoutesModule.registerTravelRoute,
                child: (context, args) => const RegisterTravelScreen(),
                guards: [FirstLocationGuard()]),
            ChildRoute(
              TrackerRoutesModule.previewCurrentLocationTravelRoute,
              child: (context, args) => const PreviewCurrentLocationScreen(
                currentStep: 2,
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.readTravelNFCRoute,
              child: (context, args) => BlocProvider.value(
                value: Modular.get<NfcCubit>()
                  ..beginScan()
                  ..startScan(),
                child: const ReadNFCTravelScreen(
                  currentStep: 3,
                ),
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.detailsTicketTravelRoute,
              child: (context, args) => const DetailsTicketTravelScreen(
                currentStep: 4,
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.previewTicketTravelRoute,
              child: (context, args) => const PreviewTicketTravelScreen(
                currentStep: 5,
              ),
            ),
          ],
        ),
      ];
}

class TrackerRouterOutlet extends StatelessWidget {
  static final AcarreoCubit _cubit = Modular.get<AcarreoCubit>();
  const TrackerRouterOutlet({super.key});

  @override
  Widget build(BuildContext context) {
    FormChangeStep? currentState;

    return BlocSelector<AcarreoCubit, AcarreoState, FormChangeStep>(
      selector: (state) {
        if (currentState == null && state is! FormChangeStep) {
          currentState = const FormChangeStep(
            index: 0,
            prevStep: '',
            step: '',
            totalSteps: 5,
          );
        }

        if (state is FormChangeStep) {
          currentState = state;
        }

        return currentState!;
      },
      builder: (context, state) {
        return GeneralTrackerWrap.withRouterOutlet(
          currentStep: state.index,
          totalSteps: state.totalSteps,
          onContinue: () => _cubit.onContinue(state),
        );
      },
    );
  }
}
