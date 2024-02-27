part of 'acarreo_cubit.dart';

abstract class AcarreoState extends Equatable {
  const AcarreoState();

  @override
  List<Object?> get props => [];
}

class AcarreoInitState extends AcarreoState {
  const AcarreoInitState();
  @override
  List<Object?> get props => [];
}

class AcarreoInitCreateTicket extends AcarreoState {
  const AcarreoInitCreateTicket();
  @override
  List<Object?> get props => [];
}

class AcarreoShowModalTicketPrint extends AcarreoState {
  const AcarreoShowModalTicketPrint();
  @override
  List<Object?> get props => [];
}

class AcarreoShowLoadingModal extends AcarreoState {
  final Map<String, dynamic> message;

  const AcarreoShowLoadingModal({required this.message});
  @override
  List<Object?> get props => [message];
}

class AcarreoSuccess extends AcarreoState {
  const AcarreoSuccess();
  @override
  List<Object?> get props => [];
}

class LoadingLocalData extends AcarreoState {
  const LoadingLocalData();
  @override
  List<Object?> get props => [];
}

class LocalDataSuccess extends AcarreoState {
  const LocalDataSuccess();
  @override
  List<Object?> get props => [];
}

class AcarreoError extends AcarreoState {
  final Map<String, dynamic> message;
  const AcarreoError(this.message);
  @override
  List<Object?> get props => [];
}

class SettingNewValueToForm extends AcarreoState {
  final Map<String, dynamic> newValue;
  const SettingNewValueToForm(this.newValue);
  @override
  List<Object?> get props => [newValue];
}

class FormChangedValue extends AcarreoState {
  final Map<String, dynamic> answers;
  const FormChangedValue(this.answers);
  @override
  List<Object?> get props => [answers];
}

class FormInitScanner extends AcarreoState {
  const FormInitScanner();
  @override
  List<Object?> get props => [];
}

class FormScannerSuccess extends AcarreoState {
  final String data;
  const FormScannerSuccess(this.data);
  @override
  List<Object?> get props => [data];
}

class FormScannerError extends AcarreoState {
  const FormScannerError();
  @override
  List<Object?> get props => [];
}
