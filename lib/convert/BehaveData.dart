
import 'dart:convert';

List<BehaveData> behaveDataFromJson(String str) => List<BehaveData>.from(json.decode(str).map((x) => BehaveData.fromJson(x)));

String behaveDataToJson(List<BehaveData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BehaveData {
  BehaveData({
    this.createdAt,
    this.cpName,
    this.cpPoints,
    this.cpStatus,
  });

  DateTime createdAt;
  String cpName;
  int cpPoints;
  String cpStatus;

  factory BehaveData.fromJson(Map<String, dynamic> json) => BehaveData(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    cpName: json["cp_name"] == null ? null : json["cp_name"],
    cpPoints: json["cp_points"] == null ? null : json["cp_points"],
    cpStatus: json["cp_status"] == null ? null : json["cp_status"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "cp_name": cpName == null ? null : cpName,
    "cp_points": cpPoints == null ? null : cpPoints,
    "cp_status": cpStatus == null ? null : cpStatus,
  };
}
