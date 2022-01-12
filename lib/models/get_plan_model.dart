import 'package:koompi_hotspot/all_export.dart';

class ModelPlan {
  ModelPlan(
      {this.username,
      this.balance,
      this.device,
      this.plan,
      this.timeLeft,
      this.status,
      this.automatically});

  String username;
  String balance;
  String device;
  String plan;
  String timeLeft;
  bool status;
  bool automatically;

  factory ModelPlan.fromJson(String str) => ModelPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelPlan.fromMap(Map<String, dynamic> json) => ModelPlan(
      username: json["username"],
      balance: json["balance"],
      device: json["device"],
      plan: json["plan"],
      timeLeft: json["time_left"],
      status: json["status"],
      automatically: json["automatically"]);

  Map<String, dynamic> toMap() => {
        "username": username,
        "balance": balance,
        "device": device,
        "plan": plan,
        "status": status,
        "automatically": automatically
      };
}

ModelPlan mPlan = ModelPlan();
