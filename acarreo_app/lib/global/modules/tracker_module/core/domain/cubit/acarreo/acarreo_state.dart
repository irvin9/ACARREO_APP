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

class AcarreoLoadingData extends AcarreoState {
  const AcarreoLoadingData();
  @override
  List<Object?> get props => [];
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
