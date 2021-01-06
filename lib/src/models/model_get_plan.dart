class ModelPlan {
  String name;
  String gender;
  String email;
  String birthdate;

  Map<String, dynamic> userData;

  ModelPlan(
      {this.name,
      this.gender,
      this.email,
      this.birthdate,});

  ModelPlan.fromJson(Map<String, dynamic> parseJson) {
    name = parseJson['name'];
    gender = parseJson['gender'];
    email = parseJson['email'];
    birthdate = parseJson['birthdate'];
  }

}

ModelPlan mPlan = ModelPlan();
