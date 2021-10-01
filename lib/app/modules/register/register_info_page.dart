import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_integrador/app/modules/register/register_bloc.dart';

class RegisterInfoPage extends StatefulWidget {
  @override
  RegisterInfoPageState createState() => RegisterInfoPageState();
}

class RegisterInfoPageState extends State<RegisterInfoPage> {
  RegisterBloc _registerBloc = Modular.get<RegisterBloc>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _techController;
  List<String> _techs = [];
  File _imageProfile;

  Future getImageFromCamera() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _imageProfile = File(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada.');
      }
    });
  }

  Future getImageFromGalley() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageProfile = File(pickedFile.path);
    });

    Modular.to.pop();
  }

  _addTechs() {
    if (_techController.text.length == 0) {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Digite uma tecnologia para adicionar'),
      ));
    } else if (_techs.contains(_techController.text)) {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Essa tecnologia já foi incluida'),
      ));
    }
    setState(() {
      _techs.add(_techController.text);
      _techController.text = '';
    });
  }

  _removeTech(String tech) {
    if (_techs.contains(tech)) {
      setState(() {
        _techs.remove(tech);
      });
    }
  }

  _openSendArchives() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: new Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: Text('Adicione uma foto de perfil',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Color(0xFF125D98),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 30, left: 30, right: 30),
                          child: Column(
                            children: [
                              ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height: 50,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    onPressed: () {
                                      getImageFromGalley();
                                    },
                                    color: Color(0xFF125D98),
                                    textColor: Color(0xFFFFFFFF),
                                    child: Container(
                                      width: 200,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons
                                                  .photo_size_select_actual_outlined,
                                              size: 27,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Acessar galeria',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 10),
                              ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width / 1.1,
                                height: 50,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                          color:
                                              Theme.of(context).accentColor)),
                                  onPressed: () {
                                    getImageFromCamera();
                                  },
                                  color: Colors.white,
                                  child: Container(
                                    width: 200,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.photo_camera,
                                            color: Color(0xFF125D98), size: 27),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Tirar fotografia',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                  color: Color(0xFF125D98),
                                                  fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  _submit() async {
    Map<String, dynamic> _data;
    if (_techs.isEmpty) {
      SnackBar _snack =
          SnackBar(content: Text("Escolha pelo menos uma tecnologia"));

      return _scaffoldKey.currentState.showSnackBar(_snack);
    }

    if (_imageProfile != null) {
      final responseUpload = await _registerBloc.uploadImage(_imageProfile.path,
          _registerBloc.registerValue["username"] + "/photoProfile");

      _data = {
        "techs": _techs,
        "image_url": responseUpload["url"],
        "role": "dev"
      };
    } else {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Escolha uma foto de perfil.'),
      ));
    }

    _registerBloc.accumulateRegister(_data);

    final first = await _registerBloc.registerOut.first;

    final response = await _registerBloc.submitRegister(first);

    if (response["statusCode"] == 201) {
      Modular.to.pushNamed("/login");
    } else if (response["statusCode"] == 400) {
      SnackBar _snack = SnackBar(content: Text(response["message"]));

      _scaffoldKey.currentState.showSnackBar(_snack);
    } else {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            'Não conseguimos concluir o seu cadastro, tente novamente mais tarde.'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _techController = TextEditingController(text: '');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                  color: Colors.black,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundImage: _imageProfile == null
                                ? AssetImage("assets/icons/profile.png")
                                : FileImage(_imageProfile),
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => _openSendArchives(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Text('Escolher foto',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: Colors.white, fontSize: 14)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _techController,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.black54),
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
                              labelText: 'Tecnologias',
                              prefixIcon: Icon(
                                Icons.developer_mode_sharp,
                                color: Colors.grey,
                              ),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                          icon: Icon(
                            Icons.add_box_rounded,
                            size: 40,
                            color: Color(0xFF3C8DAD),
                          ),
                          onPressed: () => _addTechs()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                      children: _techs.map<Widget>((tech) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xFF3C8DAD).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, left: 10, right: 35),
                            child: Text(
                              tech,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Color(0xFF3C8DAD),
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeTech(tech),
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList())
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
                    'Concluir Cadastro',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
