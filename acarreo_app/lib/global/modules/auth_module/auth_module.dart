import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/screens/login_screen.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(AuthCubit.new);
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
