import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/read_nfc_form.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class ReadNFCTravelScreen extends StatelessWidget {
  final int? currentStep;

  static const String title = 'Identifica tu Unidad';
  static const String description =
      'Leeremos su código de indentificación mediante un lector NFC.';

  static final acarreoCubit = Modular.get<AcarreoCubit>();
  static final nfcCubit = Modular.get<NfcCubit>();

  const ReadNFCTravelScreen({
    super.key,
    this.currentStep,
  });

  Future<void> _handlerNfcData(String idNfc) async {
    final typeRegister = acarreoCubit.getAnswersForm('type_register');
    final ticketCode = acarreoCubit.generateTicketCode();
    if (FormValues.mappingTypeRegister["$typeRegister"] == 'origen') {
      final value = {'Z196X110497Y997': ticketCode, 'XE92202976O4': idNfc};
      nfcCubit.write(value: value);
    } else {
      final value = await nfcCubit.read();
      if (value != null) {
        final folioTicketOrigin = value['Z196X110497Y997'];
        acarreoCubit.addAnswer('folio_ticket_origin', folioTicketOrigin);
      }
      Modular.to.navigate(GlobalRoutesApp.detailsTicketTravelRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NfcCubit, NfcState>(
      listener: (context, state) {
        if (state is NfcScanSuccess) {
          acarreoCubit.addAnswer('date', DateTime.now());
          acarreoCubit.addAnswer('truckId', state.truck.id);
          acarreoCubit.addAnswer('currentTruck', state.truck);
          _handlerNfcData(state.truck.idNfc);
        }

        if (state is NfcScanFailed) {
          DialogError.show(
            context,
            DialogMessageModel.fromMap(state.message),
            () => Modular.to
                .pushReplacementNamed(GlobalRoutesApp.registerTravelRoute),
          );
        }

        if (state is NfcWriteSuccess) {
          Modular.to.navigate(GlobalRoutesApp.detailsTicketTravelRoute);
        }

        if (state is NfcWriteFailed) {
          DialogError.show(
            context,
            DialogMessageModel.fromMap(state.message),
            () => Modular.to
                .pushReplacementNamed(GlobalRoutesApp.registerTravelRoute),
          );
        }
      },
      builder: (context, state) {
        return GeneralTrackerWrap(
          currentStep: currentStep,
          showMainButton: false,
          disableToBack: true,
          children: const [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleForm(
                  title: title,
                  description: description,
                ),
                SizedBox(height: 8.0),
                ReadNFCForm()
              ],
            )
          ],
        );
      },
    );
  }
}
