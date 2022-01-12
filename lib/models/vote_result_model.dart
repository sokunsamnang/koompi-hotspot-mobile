import 'package:koompi_hotspot/all_export.dart';

class VoteResult {
  VoteResult({
    this.id,
    this.voted,
    this.votedType,
    this.adsId,
  });

  String id;
  bool voted;
  String votedType;
  String adsId;

  factory VoteResult.fromJson(String str) =>
      VoteResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VoteResult.fromMap(Map<String, dynamic> json) => VoteResult(
        id: json['user_id'],
        voted: json['voted'],
        adsId: json['ads_id'],
        votedType: json['voted_type'],
      );

  Map<String, dynamic> toMap() => {
        "user_id": id,
        "voted": voted,
        "ads_id": adsId,
        "voted_type": votedType,
      };
}

VoteResult voteResult = VoteResult();
