import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/modules/register/register_repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Disposable {
  RegisterRepository registerRepository;
  RegisterBloc(this.registerRepository);

  BehaviorSubject _registerController = BehaviorSubject.seeded({});
  Sink get registerIn => _registerController.sink;
  Stream get registerOut => _registerController.stream;
  get registerValue => _registerController.value;

  void accumulateRegister(dynamic data) async {
    Map _first = registerValue;
    if (_first.isEmpty) {
      registerIn.add(data);
    } else {
      _first.addAll(data);
    }
    print(registerValue);
  }

  submitRegister(Map<String, dynamic> data) async {
    return await registerRepository.submitRegister(data);
  }

  uploadImage(String path, String filename) async {
    return await registerRepository.uploadImage(path, filename);
  }

  @override
  void dispose() {
    _registerController.close();
  }
}
