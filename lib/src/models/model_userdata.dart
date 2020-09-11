class ModelUserData{

  String name;
  String gender;
  String email;
  String birthdate;
  String address;

  Map<String, dynamic> userData;
  
  ModelUserData({
    this.name
  });

  ModelUserData.fromJson(Map<String,dynamic> parseJson){
    name = parseJson['name'];
    gender = parseJson['gender'];
    email = parseJson['email'];
    birthdate = parseJson['birthdate'];
    address = parseJson['address'];
  }

}
  
var mData = ModelUserData();