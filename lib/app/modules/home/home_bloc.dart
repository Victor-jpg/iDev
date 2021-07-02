import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/model/user_model.dart';
import 'package:projeto_integrador/app/modules/home/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Disposable {
  HomeRepository homeRepository;
  HomeBloc(this.homeRepository);

  BehaviorSubject _devsController = BehaviorSubject();
  Sink get devsIn => _devsController.sink;
  Stream get devsOut => _devsController.stream;
  get devsValue => _devsController.value;

  void getDevs() async {
    List<UserModel> listDevs = await homeRepository.getDevs();

    devsIn.add(listDevs);
  }

  @override
  void dispose() {
    _devsController.close();
  }
}
