import 'package:acarreo_app/global/core/acarreo_core_module.dart';

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
