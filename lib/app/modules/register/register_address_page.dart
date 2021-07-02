import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/helper/helper.dart';
import 'package:projeto_integrador/app/modules/register/register_bloc.dart';
import 'package:geocoding/geocoding.dart';

class RegisterAddressPage extends StatefulWidget {
  @override
  RegisterAddressPageState createState() => RegisterAddressPageState();
}

class RegisterAddressPageState extends State<RegisterAddressPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc = Modular.get<RegisterBloc>();
  MaskedTextController _zipCodeController;
  TextEditingController _streetController;
  TextEditingController _districtController;
  TextEditingController _houseNumberController;
  TextEditingController _complementController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _stateController;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    List<Location> locations =
        await locationFromAddress(_zipCodeController.text);

    Map<String, dynamic> _data = {
      "address": {
        "zip_code": _zipCodeController.text,
        "street": _streetController.text,
        "house_number": _houseNumberController.text,
        "district": _districtController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        "country": _countryController.text,
        "geo": {"lat": locations[0].latitude, "lng": locations[0].longitude}
      }
    };

    _registerBloc.accumulateRegister(_data);

    Modular.to.pushNamed("/register/info");
  }

  @override
  void initState() {
    super.initState();
    _zipCodeController = MaskedTextController(mask: "00000-000");
    _streetController = TextEditingController(text: '');
    _houseNumberController = TextEditingController(text: '');
    _districtController = TextEditingController(text: '');
    _cityController = TextEditingController(text: '');
    _stateController = TextEditingController(text: '');
    _countryController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        controller: _zipCodeController,
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.number,
                        validator: (String text) =>
                            Helper.lengthValidator(text, length: 8),
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
                            labelText: 'CEP',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (String text) =>
                            Helper.lengthValidator(text),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        controller: _streetController,
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
                            labelText: 'Rua',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (String text) =>
                            Helper.lengthValidator(text),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        controller: _districtController,
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
                            labelText: 'Bairro',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (String text) =>
                            Helper.lengthValidator(text),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black54),
                        controller: _houseNumberController,
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
                            labelText: 'Número',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String text) => Helper.lengthValidator(text),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.black54),
                  controller: _cityController,
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
                      labelText: 'Cidade',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String text) =>
                      Helper.lengthValidator(text, length: 2),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.black54),
                  controller: _stateController,
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
                      labelText: 'Estado',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (String text) => Helper.lengthValidator(text),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.black54),
                  controller: _countryController,
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
                      labelText: 'País',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey)),
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
