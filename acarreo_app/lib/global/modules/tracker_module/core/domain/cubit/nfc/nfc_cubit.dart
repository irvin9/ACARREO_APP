import 'package:acarreo_app/global/core/acarreo_core_module.dart';

part 'nfc_state.dart';

class NfcCubit extends Cubit<NfcState> {
  final ScanNfcRepository scanNFC;

  NfcCubit(this.scanNFC) : super(const NfcInitState());

  startScan() async {
    Future.delayed(Duration.zero);
    emit(const NfcStartedScan());
    final data = await scanNFC.startSession();
    if (data != null) {
      emit(NfcScanSuccess(data: data));
      return;
    }
    emit(const NfcScanFailed({
      'title': 'La lectura no puede ser completada',
      'description':
          'No se ha podido leer o verificar el código NFC, por favor verifique su configuración.'
    }));
  }
}
