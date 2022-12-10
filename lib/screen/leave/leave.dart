import 'package:flutter/material.dart';
import 'package:student_app/convert/LeaveData.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class Leave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตรวจสอบวันลา',
          style: kLabelStyle,
        ),
      ),
      body: GetLeave(),
    );
  }
}

class GetLeave extends StatefulWidget {
  @override
  _GetLeaveState createState() => _GetLeaveState();
}

class _GetLeaveState extends State<GetLeave> {
  List<LeaveData> _data;
  @override
  void initState() {
    super.initState();
    _checkIfLeave();
  }

  Future<List<LeaveData>> _checkIfLeave() async {
    var _api = await Network().getList("mobile_leave");
    _data = leaveDataFromJson(_api);
    // print(_data.length);
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _checkIfLeave(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_data == null) {
              return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new SizedBox(
                    height: 120,
                    child: new Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: CustomShape(),
                          child: Container(
                            height: 150,
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (15),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4A3298),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 12,
                                color: kTextColor
                                    .withOpacity(.60),
                              ),
                            ],
                          ),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "รายการสรุปประจำปีการศึกษา\n",
                                  style: TextStyle(
                                    fontSize: (18),
                                  ),
                                ),
                                TextSpan(
                                  text: "จำนวนวันลาทั้งสิ้น : " +
                                      _data.length.toString() +
                                      ' วัน',
                                  style: TextStyle(
                                    fontSize: (20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new SizedBox(
                    height: 120,
                    child: new Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: CustomShape(),
                          child: Container(
                            height: 150,
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (15),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4A3298),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 12,
                                color: kTextColor
                                    .withOpacity(.60),
                              ),
                            ],
                          ),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "รายการสรุปประจำปีการศึกษา\n",
                                  style: TextStyle(
                                    fontSize: (18),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "จำนวนวันลาทั้งสิ้น : " +
                                      _data.length.toString() +
                                      ' วัน',
                                  style: TextStyle(
                                    fontSize: (18),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Expanded(
                      child: ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            var result = snapshot.data;
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 1),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kRedColors,
                                    ),
                                    child: Icon(Icons.event_busy_outlined,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 30),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: DateFormat.yMMMMd()
                                                  .formatInBuddhistCalendarThai(
                                                      result[index].leaveDate) +
                                              "\n",
                                          style: TextStyle(
                                            color: kTextColor2,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result[index].glsName +
                                              '/' +
                                              result[index].leaveDetail,
                                          style: TextStyle(
                                            color: kTextColor.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),

                                ],
                              ),
                            );
                          })),
                ],
              );
            }
          }
          return LinearProgressIndicator();
        });
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
