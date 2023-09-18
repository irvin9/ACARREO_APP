import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/repository/acarreo_auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/service/acarreo_auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/repository/auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/ui/screens/login_screen.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AuthRepository>(AcarreoAuthRepository.new);
    i.addLazySingleton<AuthService>(AcarreoAuthService.new);
  }

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i.addLazySingleton<AuthCubit>(AuthCubit.new);
  }

  // @override
  // void binds(i) {}

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
