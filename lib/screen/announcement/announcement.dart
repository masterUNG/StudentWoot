import 'package:flutter/material.dart';
import 'package:student_app/convert/AnnouncementData.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class Announcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บันทึกถึงผู้เรียน',
          style: kLabelStyle,
        ),
      ),
      body: GetAnnouncement(),
    );
  }
}

class GetAnnouncement extends StatefulWidget {
  @override
  _GetAnnouncementState createState() => _GetAnnouncementState();
}

class _GetAnnouncementState extends State<GetAnnouncement> {
  List<AnnouncementData> _data;
  @override
  void initState() {
    super.initState();
    _checkIfAnnouncement();
  }

  Future<List<AnnouncementData>> _checkIfAnnouncement() async {
    var _api = await Network().getList("mobile_announcement");
    _data = announcementDataFromJson(_api);
    // print(_data);
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _checkIfAnnouncement(),
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
                            color: kGreenColor,
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
                                  text: "จำนวนบันทึกถึงผู้เรียนทั้งสิ้น : " +
                                      _data.length.toString() +
                                      ' รายการ',
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
                            color: kTextLigntColor,
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
                                  text: "จำนวนบันทึกถึงผู้เรียนทั้งสิ้น : " +
                                      _data.length.toString() +
                                      ' รายการ',
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
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                 Container(
                                    margin: EdgeInsets.only(left: 1),
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kBestSellerColor,
                                    ),
                                    child: Icon(Icons.announcement,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: DateFormat.yMMMMd()
                                              .formatInBuddhistCalendarThai(
                                              result[index].oamDateStart) +
                                              "\n",
                                          style: TextStyle(
                                            color: kTextColor2,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result[index].courseName +
                                              '\n',
                                          style: TextStyle(
                                            color: kTextColor.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result[index].oamHead +
                                              '\n',
                                          style: TextStyle(
                                            color: kTextColor.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                                  // Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                    onPressed:  () => {},
                                  )
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
