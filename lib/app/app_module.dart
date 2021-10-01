import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/app_widget.dart';
import 'package:projeto_integrador/app/config/client_http.dart';
import 'package:projeto_integrador/app/modules/home/home_bloc.dart';
import 'package:projeto_integrador/app/modules/home/home_module.dart';
import 'package:projeto_integrador/app/modules/home/home_repository.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';
import 'package:projeto_integrador/app/modules/login/login_module.dart';
import 'package:projeto_integrador/app/modules/login/login_repository.dart';
import 'package:projeto_integrador/app/modules/profile/profile_module.dart';
import 'package:projeto_integrador/app/modules/register/register_bloc.dart';
import 'package:projeto_integrador/app/modules/register/register_module.dart';
import 'package:projeto_integrador/app/modules/register/register_repository.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => ClientHttp(),
      isSingleton: true,
    ),
    Bind((i) => RegisterRepository(i.get<ClientHttp>().getClient())),
    Bind((i) => RegisterBloc(i.get<RegisterRepository>())),
    Bind((i) => LoginRepository(i.get<ClientHttp>().getClient())),
    Bind((i) => LoginBloc(i.get<LoginRepository>())),
    Bind((i) => HomeRepository(i.get<ClientHttp>().getClient())),
    Bind((i) => HomeBloc(i.get<HomeRepository>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule()),
    ModuleRoute("/register", module: RegisterModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/profile", module: ProfileModule()),
  ];
  @override
  Widget get bootstrap => AppWidget();

  // static Inject get to => Inject<AppModule>();
}
