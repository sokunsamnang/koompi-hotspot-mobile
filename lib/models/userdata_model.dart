class ModelUserData {
  String fullname;
  String gender;
  String email;
  String phone;
  String birthdate;
  String address;
  String image = '';
  String wallet;
  String playerid;

  Map<String, dynamic> userData;

  ModelUserData(
      {this.fullname,
      this.gender,
      this.email,
      this.phone,
      this.birthdate,
      this.address,
      this.image,
      this.wallet,
      this.playerid});

  ModelUserData.fromJson(Map<String, dynamic> parseJson) {
    fullname = parseJson['fullname'];
    gender = parseJson['gender'];
    email = parseJson['email'];
    phone = parseJson['phone'];
    birthdate = parseJson['birthdate'];
    address = parseJson['address'];
    image = parseJson['image'];
    wallet = parseJson['wallet'];
    playerid = parseJson['player_id'];
  }
}

ModelUserData mData = ModelUserData();
