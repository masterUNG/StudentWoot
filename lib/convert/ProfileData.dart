import 'dart:convert';

ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    this.schoolName,
    this.photo,
    this.className,
    this.studentCode,
    this.semesters,
    this.fullName,
  });

  String schoolName;
  String photo;
  String className;
  String studentCode;
  String semesters;
  String fullName;


  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    schoolName: json["schoolName"] == null ? null : json["schoolName"],
    photo: json["photo"] == null ? null : json["photo"],
    className: json["className"] == null ? null : json["className"],
    studentCode: json["studentCode"] == null ? null : json["studentCode"],
    semesters: json["semesters"] == null ? null : json["semesters"],
    fullName: json["fullName"] == null ? null : json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "schoolName": schoolName == null ? null : schoolName,
    "photo": photo == null ? null : photo,
    "className": className == null ? null : className,
    "studentCode": studentCode == null ? null : studentCode,
    "semesters": semesters == null ? null : semesters,
    "fullName": fullName == null ? null : fullName,
  };
}
