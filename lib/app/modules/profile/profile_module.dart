import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';
import 'package:projeto_integrador/app/modules/login/login_page.dart';
import 'package:projeto_integrador/app/modules/login/login_repository.dart';
import 'package:projeto_integrador/app/modules/profile/profile_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProfilePage()),
  ];

  // static Inject get to => Inject<LoginModule>();
}
