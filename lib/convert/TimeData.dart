// To parse this JSON data, do
//
//     final timeData = timeDataFromJson(jsonString);

import 'dart:convert';

List<TimeData> timeDataFromJson(String str) => List<TimeData>.from(json.decode(str).map((x) => TimeData.fromJson(x)));

String timeDataToJson(List<TimeData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeData {
  TimeData({
    this.taDate,
    this.taTimein,
    this.taTimeout,
    this.taStatus,
    this.dateType,
    this.taColor,
  });

  DateTime taDate;
  String taTimein;
  String taTimeout;
  String taStatus;
  String dateType;
  String taColor;

  factory TimeData.fromJson(Map<String, dynamic> json) => TimeData(
    taDate: json["ta_date"] == null ? null : DateTime.parse(json["ta_date"]),
    taTimein: json["ta_timein"] == null ? null : json["ta_timein"],
    taTimeout: json["ta_timeout"] == null ? null : json["ta_timeout"],
    taStatus: json["TA_STATUS"] == null ? null : json["TA_STATUS"],
    taColor: json["STATUS_COLOR"] == null ? null : json["STATUS_COLOR"],
    dateType: json["date_type"] == null ? null : json["date_type"],
    // taStatus: json["TA_STATUS"] == null ? null : taStatusValues.map[json["TA_STATUS"]],
    // dateType: json["date_type"] == null ? null : dateTypeValues.map[json["date_type"]],
  );

  Map<String, dynamic> toJson() => {
    "ta_date": taDate == null ? null : "${taDate.year.toString().padLeft(4, '0')}-${taDate.month.toString().padLeft(2, '0')}-${taDate.day.toString().padLeft(2, '0')}",
    "ta_timein": taTimein == null ? null : taTimein,
    "ta_timeout": taTimeout == null ? null : taTimeout,
    "TA_STATUS": taStatus == null ? null : [taStatus],
    "STATUS_COLOR": taColor == null ? null : [taColor],
    "date_type": dateType == null ? null : [dateType],
    // "TA_STATUS": taStatus == null ? null : taStatusValues.reverse[taStatus],
    // "date_type": dateType == null ? null : dateTypeValues.reverse[dateType],
  };
}

// enum DateType { EMPTY, DATE_TYPE }

// final dateTypeValues = EnumValues({
//   "วันหยุด ส/อา": DateType.DATE_TYPE,
//   "วันเรียนปกติ": DateType.EMPTY
// });
//
// enum TaStatus { EMPTY, TA_STATUS, ONLINE, TA_STATUS_ONLINE }
//
// final taStatusValues = EnumValues({
//   "เช็คขาดโดยระบบ": TaStatus.EMPTY,
//   "ปกติ (Online)": TaStatus.ONLINE,
//   "ปกติ": TaStatus.TA_STATUS,
//   "สาย (Online)": TaStatus.TA_STATUS_ONLINE
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
