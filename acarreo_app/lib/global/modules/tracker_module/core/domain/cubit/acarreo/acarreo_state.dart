import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_loader.dart';

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

class AcarreoError extends AcarreoState {
  const AcarreoError();
  @override
  List<Object?> get props => [];
}
