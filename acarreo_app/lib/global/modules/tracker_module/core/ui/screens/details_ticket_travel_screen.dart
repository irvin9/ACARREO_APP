import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/details_ticket_form.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DetailsTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  static final StorageService storage = Modular.get<StorageService>();

  const DetailsTicketTravelScreen({
    super.key,
    this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final currentUser = storage.currentUser;
    final cubit = Modular.get<AcarreoCubit>();

    const String title = 'Detalles de la Ubicación';

    return GeneralTrackerWrap(
      currentStep: currentStep,
      onContinue: () {
        if (formKey.currentState!.validate()) {
          if (currentUser.idModule == 1) {
            cubit.addAnswer('date', DateTime.now());
            cubit.generateTicketCode();
          }
          Modular.to.navigate(GlobalRoutesApp.previewTicketTravelRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Complete los campos faltantes!')),
          );
        }
      },
      disableToBack: true,
      children: [
        const TitleForm(
          title: title,
        ),
        getTicketForm(currentUser.idModule, formKey)
      ],
    );
  }

  getTicketForm(int module, GlobalKey<FormState> key) {
    if (module == 0) {
      return DetailsTicketForm(formKey: key);
    } else {
      return DetailsTicketBankForm(formKey: key);
    }
  }
}
