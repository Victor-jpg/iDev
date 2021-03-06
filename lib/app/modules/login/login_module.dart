import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';
import 'package:projeto_integrador/app/modules/login/login_page.dart';
import 'package:projeto_integrador/app/modules/login/login_repository.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => i.get<LoginRepository>(),
    ),
    Bind(
      (i) => LoginBloc(i.get<LoginRepository>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
    ChildRoute("/login", child: (_, args) => LoginPage()),
  ];

  // static Inject get to => Inject<LoginModule>();
}
