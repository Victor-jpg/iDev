import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_integrador/app/model/user_model.dart';
import 'package:projeto_integrador/app/modules/home/home_bloc.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

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
  BitmapDescriptor icon;
  Dio dio;
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List listMarkers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  markers(List<UserModel> users) {
    return users.map((e) {
      return Marker(
          onTap: () {
            _configButtonSheet(context, e.username);
          },
          markerId: MarkerId(e.username),
          position: LatLng(e.lat, e.lng));
    }).toList();
  }

  void moveCameraToMarked(double latitude, double longitude) {
    Modular.to.pop();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: (LatLng(latitude, longitude)), zoom: 15)));
  }

  void _configButtonSheet(context, String username) {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                StreamBuilder(
                    stream: _homeBloc.devsOut,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<UserModel> users = snapshot.data;

                      return Container(
                        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: ListView(
                          children: users.map((e) {
                            return GestureDetector(
                              onTap: () => moveCameraToMarked(e.lat, e.lng),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        e.imageUrl != null
                                            ? Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: username ==
                                                                e.username
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e.imageUrl.trim()),
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
                                        SizedBox(width: 15),
                                        Text(e.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                    color:
                                                        username != e.username
                                                            ? Colors.black54
                                                            : Color(0xFF125D98),
                                                    fontWeight:
                                                        username != e.username
                                                            ? FontWeight.normal
                                                            : FontWeight.w600)),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 50),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.green),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                                '${e.street}, ${e.houseNumber}, ${e.district} - ${e.city}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        color: username !=
                                                                e.username
                                                            ? Colors.black54
                                                            : Color(0xFF125D98),
                                                        fontWeight: username !=
                                                                e.username
                                                            ? FontWeight.normal
                                                            : FontWeight.w600,
                                                        fontSize: 14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      margin: EdgeInsets.only(left: 50),
                                      child: Row(
                                        children: [
                                          Icon(Icons.developer_mode_sharp),
                                          SizedBox(width: 5),
                                          Wrap(
                                              children: e.techs.map((tech) {
                                            return Row(
                                              children: [
                                                Text(tech,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        ?.copyWith(
                                                            color: username !=
                                                                    e.username
                                                                ? Colors.black54
                                                                : Color(
                                                                    0xFF125D98),
                                                            fontWeight: username !=
                                                                    e.username
                                                                ? FontWeight
                                                                    .normal
                                                                : FontWeight
                                                                    .w600,
                                                            fontSize: 14)),
                                                SizedBox(width: 5)
                                              ],
                                            );
                                          }).toList()),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
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

  getDevsValue() async {
    final first = await _homeBloc.devsOut.first;

    return first;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc.getCurrentUser();
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration(), "assets/icons/marker_icon.png")
    //     .then((value) => icon = value);

    _homeBloc.getDevs(_loginBloc.userTokenValue);

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        listMarkers = markers(_homeBloc.devsValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(markers);
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
          'iDevs',
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Perfil"),
                  onTap: () {
                    Modular.to.pushReplacementNamed("/profile");
                  }),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Modular.to.pushReplacementNamed("/login");
                  }),
            ],
          ),
        ],
      )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder<Object>(
                    stream: _loginBloc.userDataOut,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      UserModel user = snapshot.data;
                      return Container(
                        child: GoogleMap(
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: _onMapCreated,
                          markers: Set.from(listMarkers),
                          initialCameraPosition: CameraPosition(
                              target: LatLng(user.lat, user.lng), zoom: 15),
                        ),
                      );
                    }),
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
                onPressed: () => _configButtonSheet(context, ""),
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
