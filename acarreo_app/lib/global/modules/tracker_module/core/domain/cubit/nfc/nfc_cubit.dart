import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';

part 'nfc_state.dart';

class NfcCubit extends Cubit<NfcState> {
  final ScanNfcRepository scanNFC;
  final AcarreoDataManagerService managerService;

  NfcCubit(this.scanNFC, this.managerService) : super(const NfcInitState());

  startScan() async {
    Future.delayed(Duration.zero);
    emit(const NfcStartedScan());
    final String? idNfc = await scanNFC.startSession();
    if (idNfc != null) {
      final currentTruck = managerService.trucks
          .cast<AcarreoTruck?>()
          .firstWhere(
              (element) => element?.idNfc.toLowerCase() == idNfc.toLowerCase(),
              orElse: () => null);
      if (currentTruck != null) {
        emit(NfcScanSuccess(truck: currentTruck));
        return;
      }
    }
    await closeScan();
    emit(const NfcScanFailed({
      'title': 'La lectura no puede ser completada',
      'description': 'No se ha podido leer o verificar el código NFC.'
    }));
  }

  Future<void> write({required Map<String, dynamic> value}) async {
    await scanNFC.writeNfcData(value);
    await closeScan();
  }

  Future<Map<String, dynamic>?> read() async {
    final data = await scanNFC.readNfcData();
    await closeScan();
    return data;
  }

  closeScan() async {
    await scanNFC.stopSession();
  }
}
