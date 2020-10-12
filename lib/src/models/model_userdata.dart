class ModelUserData{

  String name;
  String gender;
  String email;
  String birthdate;
  String address;
  dynamic image;

  Map<String, dynamic> userData;
  
  ModelUserData({
    this.name,
    this.gender,
    this.email,
    this.birthdate,
    this.address,
    this.image
  });

  ModelUserData.fromJson(Map<String,dynamic> parseJson){
    name = parseJson['name'];
    gender = parseJson['gender'];
    email = parseJson['email'];
    birthdate = parseJson['birthdate'];
    address = parseJson['address'];
    image = parseJson['image'];
  }

  Map<String, dynamic> fetchEmail = {};
}
  
var mData = ModelUserData();