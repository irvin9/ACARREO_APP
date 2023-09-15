import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/repository/acarreo_auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/service/acarreo_auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/repository/auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/ui/screens/login_screen.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addSingleton<StorageService>(FlutterStorageService.new);
    i.addSingleton<EnviromentService>(FlutterEnvironmentService.new);
    i.addSingleton<HttpService>(FlutterHttpService.new);
    i.addSingleton<AuthRepository>(AcarreoAuthRepository.new);
    i.addSingleton<AuthService>(AcarreoAuthService.new);
    i.addSingleton<AuthCubit>(AuthCubit.new);
  }

  @override
  void binds(i) {}

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
