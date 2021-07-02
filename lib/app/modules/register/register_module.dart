import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/register/register_address_page.dart';
import 'package:projeto_integrador/app/modules/register/register_bloc.dart';
import 'package:projeto_integrador/app/modules/register/register_info_page.dart';
import 'package:projeto_integrador/app/modules/register/register_page.dart';
import 'package:projeto_integrador/app/modules/register/register_repository.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => i.get<RegisterRepository>(),
    ),
    Bind(
      (i) => RegisterBloc(i.get<RegisterRepository>()),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => RegisterPage()),
    ChildRoute("/address", child: (_, args) => RegisterAddressPage()),
    ChildRoute("/info", child: (_, args) => RegisterInfoPage()),
  ];

  // static Inject get to => Inject<LoginModule>.of();
}
