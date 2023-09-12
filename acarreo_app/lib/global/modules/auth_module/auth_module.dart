import 'package:flutter_modular/flutter_modular.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/screens/login_screen.dart';

class AuthModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/login', child: (context) => const LoginScreen());
  }
}
