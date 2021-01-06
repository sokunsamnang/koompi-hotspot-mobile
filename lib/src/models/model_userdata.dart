import 'package:koompi_hotspot/index.dart';

class ModelUserData {
  String name;
  String gender;
  String email;
  String birthdate;
  String address;
  String image = '';
  String wallet;

  Map<String, dynamic> userData;

  ModelUserData(
      {this.name,
      this.gender,
      this.email,
      this.birthdate,
      this.address,
      this.image,
      this.wallet});

  ModelUserData.fromJson(Map<String, dynamic> parseJson) {
    name = parseJson['name'];
    gender = parseJson['gender'];
    email = parseJson['email'];
    birthdate = parseJson['birthdate'];
    address = parseJson['address'];
    image = parseJson['image'];
    wallet = parseJson['wallet'];
  }

  Map<String, dynamic> fetchEmail = {};
}

ModelUserData mData = ModelUserData();
