import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_integrador/app/modules/home/home_bloc.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomeBloc _homeBloc = Modular.get<HomeBloc>();
  LoginBloc _loginBloc = Modular.get<LoginBloc>();
  CameraPosition initialCamera;
  GoogleMapController mapController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _configButtonSheet(context) {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey),
                                ),
                                SizedBox(width: 15),
                                Text('Victor Augusto',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.green),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                        'Rua Benedito Barcelos, 111, Bela Vista - Vitória',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                color: Colors.black54,
                                                fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Row(
                                children: [
                                  Icon(Icons.developer_mode_sharp),
                                  SizedBox(width: 5),
                                  Text('Elixir',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black),
                        //     borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey),
                                ),
                                SizedBox(width: 15),
                                Text('Elioenai',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: Colors.black54)),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.green),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                        'Rua Benedito Barcelos, 111, Bela Vista - Vitória',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                color: Colors.black54,
                                                fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Row(
                                children: [
                                  Icon(Icons.developer_mode_sharp),
                                  SizedBox(width: 5),
                                  Text('JavaScript, Flutter',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF125D98),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: IconButton(
                      onPressed: () => Modular.to.pop(),
                      icon: Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _homeBloc.getDevs();
    _loginBloc.getCurrentUser();
    // initialCamera = CameraPosition(
    //     target:
    //         LatLng(_loginBloc.userDataValue.lat, _loginBloc.userDataValue.lng),
    //     zoom: 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF125D98),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF125D98),
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        title: Text(
          'Home',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Modular.to.pushReplacementNamed("/login");
                  })
            ],
          ),
          SizedBox(height: 30)
        ],
      )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.7,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: {},
                    initialCameraPosition: initialCamera,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF125D98),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: IconButton(
                onPressed: () => _configButtonSheet(context),
                icon: Icon(
                  Icons.arrow_drop_up_sharp,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
