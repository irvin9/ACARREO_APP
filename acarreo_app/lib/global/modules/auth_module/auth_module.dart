import 'package:acarreo_app/global/core/domain/service/environment_service.dart';
import 'package:acarreo_app/global/core/domain/service/http_service.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/repository/auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/service/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:acarreo_app/global/core/data/service/flutter_http_service.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/screens/login_screen.dart';
import 'package:acarreo_app/global/core/data/service/flutter_environment_service.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/data/service/acarreo_auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/data/repository/acarreo_auth_repository.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addSingleton<EnviromentService>(FlutterEnvironmentService.new);
    i.addSingleton<HttpService>(FlutterHttpService.new);
    i.addSingleton<AuthRepository>(AcarreoAuthRepository.new);
    i.addSingleton<AuthService>(AcarreoAuthService.new);
    i.addSingleton<AuthCubit>(AuthCubit.new);
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
