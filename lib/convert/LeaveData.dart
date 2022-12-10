import 'dart:convert';

List<LeaveData> leaveDataFromJson(String str) => List<LeaveData>.from(json.decode(str).map((x) => LeaveData.fromJson(x)));

String leaveDataToJson(List<LeaveData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveData {
  LeaveData({
    this.id,
    this.glsName,
    this.leaveDate,
    this.leaveDetail,
    this.userRecord,
  });

  int id;
  String glsName;
  DateTime leaveDate;
  String leaveDetail;
  String userRecord;

  factory LeaveData.fromJson(Map<String, dynamic> json) => LeaveData(
    id: json["id"] == null ? null : json["id"],
    glsName: json["gls_name"] == null ? null : json["gls_name"],
    leaveDate: json["leave_date"] == null ? null : DateTime.parse(json["leave_date"]),
    leaveDetail: json["leave_detail"] == null ? null : json["leave_detail"],
    userRecord: json["user_record"] == null ? null : json["user_record"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "gls_name": glsName == null ? null : glsName,
    "leave_date": leaveDate == null ? null : "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
    "leave_detail": leaveDetail == null ? null : leaveDetail,
    "user_record": userRecord == null ? null : userRecord,
  };
}