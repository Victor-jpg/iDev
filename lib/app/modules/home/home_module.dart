import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/home/home_bloc.dart';
import 'package:projeto_integrador/app/modules/home/home_page.dart';
import 'package:projeto_integrador/app/modules/home/home_repository.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => i.get<HomeRepository>(),
    ),
    Bind(
      (i) => HomeBloc(i.get<HomeRepository>()),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];

  // static Inject get to => Inject<LoginModule>.of();
}
