import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/repository/acarreo_auth_repository.dart';
import 'package:acarreo_app/global/modules/auth_module/core/data/service/acarreo_auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/core/ui/screens/login_screen.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => AcarreoAuthRepository(), export: true),
        Bind.singleton((i) => AcarreoAuthService(repository: i()),
            export: true),
        Bind.singleton((i) => AuthCubit(service: i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/login',
          child: (context, args) => BlocProvider.value(
            value: Modular.get<AuthCubit>(),
            child: const LoginScreen(),
          ),
        ),
      ];
}
