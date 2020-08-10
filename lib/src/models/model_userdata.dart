class ModelUserData{

  String fullname;

  ModelUserData({
    this.fullname
  });

  ModelUserData.fromJson(Map<String,dynamic> parseJson){
    fullname = parseJson['full_name'];
  }

}
  
var mData = ModelUserData();