import 'package:acarreo_app/global/modules/auth_module/domain/repository/auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/service/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/screens/login_screen.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/data/service/acarreo_auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/data/repository/acarreo_auth_repository.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<AuthCubit>(AuthCubit.new);
  }

  @override
  void binds(i) {
    i.addSingleton<AuthRepository>(AcarreoAuthRepository.new);
    i.addSingleton<AuthService>(AcarreoAuthService.new);
  }

  @override
  void routes(r) {
    r.child(
      '/login',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthCubit>(),
        child: const LoginScreen(),
      ),
    );
  }
}
