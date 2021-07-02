import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/login/login_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Disposable {
  LoginRepository loginRepository;
  LoginBloc(this.loginRepository);

  BehaviorSubject _userDataController = BehaviorSubject();
  Sink get userDataIn => _userDataController.sink;
  get userDataValue => _userDataController.value;
  Stream get userDataOut => _userDataController.stream;

  BehaviorSubject _userTokenController = BehaviorSubject();
  Sink get userTokenIn => _userTokenController.sink;
  get userTokenValue => _userTokenController.value;

  Future fazerLogin(String email, String password) async {
    LoginEvent login = await loginRepository.login(email, password);

    if (login.isValid) {
      userTokenIn.add(login.userToken);
      return login.isValid;
    }
    return login.isValid;
  }

  void getCurrentUser() async {
    CurrentUser currentUser = await loginRepository.currentUser();

    userDataIn.add(currentUser.userData);
  }

  @override
  void dispose() {}
}
