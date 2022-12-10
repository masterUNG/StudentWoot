import 'package:flutter/material.dart';
import 'package:student_app/convert/TimeData.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class Timeattendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตรวจสอบเวลาเรียน',
          style: kLabelStyle,
        ),
      ),
      body: GetTimetendance(),
    );
  }
}

class GetTimetendance extends StatefulWidget {
  @override
  _GetTimetendanceState createState() => _GetTimetendanceState();
}

class _GetTimetendanceState extends State<GetTimetendance> {
  List<TimeData> _timeData;
  @override
  void initState() {
    super.initState();
    _checkIfTime();
  }

  Future<List<TimeData>> _checkIfTime() async {
    var _data = await Network().getList("mobile_time_attendance");
    _timeData = timeDataFromJson(_data);
    return _timeData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkIfTime(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: _timeData.length,
                itemBuilder: (context, index) {
                  var result = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 1),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: result[index].taColor == '0' ? kRedColors :
                            (result[index].taColor == '1' ? kGreenColor :
                            (result[index].taColor == '2' ? kOrangeColors :
                            (result[index].taColor == '3' ? kPepleColors :
                            kTextColor2
                            )) ),
                          ),
                          child: Icon(Icons.access_alarm, color: Colors.white),
                        ),
                        SizedBox(width: 15),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: DateFormat.yMMMMd()
                                        .formatInBuddhistCalendarThai(
                                            result[index].taDate) +
                                    result[index].taColor
                                    +
                                    "\n",
                                style: TextStyle(
                                  color: kTextColor2,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'เวลาเข้า : ' + result[index].taTimein,
                                style: TextStyle(
                                  color: kTextColor.withOpacity(.5),
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: ' / ',
                                style: TextStyle(
                                  color: kTextColor.withOpacity(.5),
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'เวลากลับ : ' +
                                    result[index].taTimeout +
                                    '\n',
                                style: TextStyle(
                                  color: kTextColor.withOpacity(.5),
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text:  result[index].taStatus,
                                style: TextStyle(
                                  color: kTextColor2.withOpacity(.5),
                                  fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' : ' +
                                    '(' + result[index].dateType + ')'
                                ,
                                style: TextStyle(
                                  color: kTextColor.withOpacity(.5),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                });
          }
          return LinearProgressIndicator();
        });
  }
}
