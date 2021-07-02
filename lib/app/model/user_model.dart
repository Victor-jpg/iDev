class UserModel {
  double lat;
  double lng;
  String zipCode;
  String houseNumber;
  String district;
  String city;
  String state;
  String street;
  String country;
  String role;
  List techs;
  String uid;
  String username;
  String email;
  String imageUrl;

  UserModel(
      {this.lat,
      this.lng,
      this.zipCode,
      this.city,
      this.country,
      this.district,
      this.street,
      this.email,
      this.houseNumber,
      this.imageUrl,
      this.role,
      this.state,
      this.techs,
      this.uid,
      this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["_id"];
    lat = json["address"]["geo"]["lat"] != 0
        ? json["address"]["geo"]["lat"]
        : 0.0;
    lng = json["address"]["geo"]["lng"] != 0
        ? json["address"]["geo"]["lng"]
        : 0.0;
    zipCode = json["address"]["zip_code"];
    street = json["address"]["street"];
    houseNumber = json["address"]["house_number"];
    district = json["address"]["district"];
    city = json["address"]["city"];
    state = json["address"]["state"];
    country = json["address"]["country"];
    role = json["role"];
    techs = json["techs"];
    username = json["username"];
    email = json["email"];
    imageUrl = json["image_url"];
  }
}
