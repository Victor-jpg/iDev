import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/helper/helper.dart';
import 'package:projeto_integrador/app/model/user_model.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc = Modular.get<LoginBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF125D98),
        leading: IconButton(
            onPressed: () => Modular.to.pushNamed("/home"),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          'Perfil',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: StreamBuilder<Object>(
              stream: _loginBloc.userDataOut,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                UserModel user = snapshot.data;
                return Column(
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
                        child: user.imageUrl != null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(user.imageUrl.trim()),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle),
                              )
                            : Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/icon/profile.png")),
                                    shape: BoxShape.circle,
                                    color: Colors.grey),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(user.username,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    Text(user.email,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF125D98)),
                            SizedBox(width: 5),
                            Text('Logradouro: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                            Text(user.street)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF125D98)),
                            SizedBox(width: 5),
                            Text('Bairro: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                            Text(user.district)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF125D98)),
                            SizedBox(width: 5),
                            Text('Número: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                            Text(user.houseNumber)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF125D98)),
                            SizedBox(width: 5),
                            Text('Cidade: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                            Text(user.city)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF125D98)),
                            SizedBox(width: 5),
                            Text('País: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                            Text(user.country)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(Icons.developer_mode_sharp),
                        SizedBox(width: 5),
                        Wrap(
                            children: user.techs.map((tech) {
                          return Row(
                            children: [
                              Text(tech,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                              SizedBox(width: 5)
                            ],
                          );
                        }).toList()),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
