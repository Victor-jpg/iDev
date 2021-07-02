import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/helper/helper.dart';
import 'package:projeto_integrador/app/modules/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc = Modular.get<RegisterBloc>();
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  bool _obscureText;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _confirmPasswordController = TextEditingController(text: '');
    _obscureText = false;
  }

  _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    Map<String, dynamic> _data = {
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    };

    _registerBloc.accumulateRegister(_data);

    Modular.to.pushNamed("/register/address");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF125D98),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Color(0xFF125D98),
        title: Text(
          'Registre-se',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                          'Faça parte da comunidade iDev, onde você pode encontrar outros desenvolvedores próximos de você',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Color(0xFF125D98))),
                      SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        validator: (String text) =>
                            Helper.lengthValidator(text),
                        controller: _usernameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Nome de usuário',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        validator: (String text) => Helper.emailValidator(text),
                        controller: _emailController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.alternate_email_outlined,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        validator: (String text) =>
                            Helper.lengthValidator(text, length: 6),
                        obscureText: _obscureText,
                        controller: _passwordController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Senha',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                )),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        validator: (String text) => Helper.equalValidator(text,
                            value: _passwordController.text),
                        controller: _confirmPasswordController,
                        obscureText: _obscureText,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Confirmar senha',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                )),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFF3C8DAD),
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      'Continuar Cadastro',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
