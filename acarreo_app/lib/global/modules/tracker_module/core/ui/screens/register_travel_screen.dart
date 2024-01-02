import 'package:flutter/material.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/register_travel_form.dart';

class RegisterTravelScreen extends StatelessWidget {
  const RegisterTravelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<AcarreoCubit>();
    final formKey = cubit.formKey;
    final currentUser = cubit.storage.currentUser;

    const String title = 'Registrar Ubicación';
    const String description =
        'Registra la información del la ubicación, le tomará unos minutos. '
        'Necesitamos almacenar el tipo de ubicación.';

    const String titleH2 = 'Detalles de la ubicación';
    const String descriptionH2 = 'Añade los detalles de tu ubicación';

    return [
      const TitleForm(
        title: title,
        description: description,
      ),
      const SizedBox(height: 8.0),
      TitleForm.h2(
        title: titleH2,
        description: descriptionH2,
      ),
      const SizedBox(height: 12.0),
      if (currentUser.idModule == 0)
        RegisterTravelForm(formKey: formKey)
      else
        RegisterTravelBankForm(formKey: formKey)
    ].setSingleScroll();
  }
}
