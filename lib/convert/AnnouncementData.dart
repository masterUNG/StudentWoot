import 'dart:convert';

List<AnnouncementData> announcementDataFromJson(String str) => List<AnnouncementData>.from(json.decode(str).map((x) => AnnouncementData.fromJson(x)));

String announcementDataToJson(List<AnnouncementData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncementData {
  AnnouncementData({
    this.oamHead,
    this.oamDateStart,
    this.courseName,
    this.oamType,
  });

  String oamHead;
  DateTime oamDateStart;
  String courseName;
  int oamType;

  factory AnnouncementData.fromJson(Map<String, dynamic> json) => AnnouncementData(
    oamHead: json["oam_head"] == null ? null : json["oam_head"],
    oamDateStart: json["oam_date_start"] == null ? null : DateTime.parse(json["oam_date_start"]),
    courseName: json["course_name"] == null ? null : json["course_name"],
    oamType: json["oam_type"] == null ? null : json["oam_type"],
  );

  Map<String, dynamic> toJson() => {
    "oam_head": oamHead == null ? null : oamHead,
    "oam_date_start": oamDateStart == null ? null : "${oamDateStart.year.toString().padLeft(4, '0')}-${oamDateStart.month.toString().padLeft(2, '0')}-${oamDateStart.day.toString().padLeft(2, '0')}",
    "course_name": courseName == null ? null : courseName,
    "oam_type": oamType == null ? null : oamType,
  };
}
