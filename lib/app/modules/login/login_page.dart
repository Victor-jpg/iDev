import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/helper/helper.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginBloc _loginBloc = Modular.get();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool obscureText;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final loginIsValid = await _loginBloc.fazerLogin(
        _emailController.text, _passwordController.text);

    print("LOGINISVALID");
    print(loginIsValid);

    if (loginIsValid) {
      Modular.to.pushNamed("/home");
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Credenciais Inválidas"),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    obscureText = false;
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF125D98),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            height: 300,
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (String text) =>
                            Helper.lengthValidator(text),
                        textAlignVertical: TextAlignVertical.bottom,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String text) =>
                            Helper.lengthValidator(text, length: 6),
                        obscureText: !obscureText,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
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
                                    obscureText = !obscureText;
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
                        'Entrar',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Text(
          //   'Esqueceu sua senha?',
          //   style: Theme.of(context).textTheme.subtitle1?.copyWith(
          //       color: Theme.of(context).primaryColor,
          //       fontSize: 14,
          //       fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 80),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text.rich(TextSpan(
                text: 'Não possui conta? ',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                children: [
                  TextSpan(
                    text: 'Registre-se agora',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Modular.to.pushNamed('/register');
                      },
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
