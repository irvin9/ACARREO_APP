part of 'nfc_cubit.dart';

abstract class NfcState extends Equatable {
  const NfcState();
}

class NfcInitState extends NfcState {
  const NfcInitState();

  @override
  List<Object?> get props => [];
}

class NfcStartedScan extends NfcState {
  const NfcStartedScan();

  @override
  List<Object?> get props => [];
}

class NfcScanSuccess extends NfcState {
  final String data;

  const NfcScanSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class NfcScanFailed extends NfcState {
  final Map<String, dynamic> message;
  const NfcScanFailed(this.message);

  @override
  List<Object?> get props => [message];
}
