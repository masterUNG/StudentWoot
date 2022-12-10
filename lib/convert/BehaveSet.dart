import 'dart:convert';

BehaveSet behaveSetFromJson(String str) => BehaveSet.fromJson(json.decode(str));

String behaveSetToJson(BehaveSet data) => json.encode(data.toJson());

class BehaveSet {
  BehaveSet({
    this.sumcp,
    this.tolet,
    this.full,
  });

  String sumcp;
  int tolet;
  int full;

  factory BehaveSet.fromJson(Map<String, dynamic> json) => BehaveSet(
    sumcp: json["sumcp"] == null ? null : json["sumcp"],
    tolet: json["tolet"] == null ? null : json["tolet"],
    full: json["full"] == null ? null : json["full"],
  );

  Map<String, dynamic> toJson() => {
    "sumcp": sumcp == null ? null : sumcp,
    "tolet": tolet == null ? null : tolet,
    "full": full == null ? null : full,
  };
}