import 'package:flutter/material.dart';
import 'package:student_app/convert/BehaveData.dart';
import 'package:student_app/convert/BehaveSet.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class Behave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตรวจสอบคะแนนความประพฤติ',
          style: kLabelStyle,
        ),
      ),
      body: GetBehave(),
    );
  }
}

class GetBehave extends StatefulWidget {
  @override
  _GetBehaveState createState() => _GetBehaveState();
}

class _GetBehaveState extends State<GetBehave> {
  List<BehaveData> _data;
  BehaveSet _set;
  @override
  void initState() {
    super.initState();
     _checkIfSet();
     if(_set != null){
       _checkIfBehave();
     }

  }
  Future <BehaveSet> _checkIfSet() async {
    var _api2 = await Network().getList("mobile_behaveset");
    _set = behaveSetFromJson(_api2);
    // print(_set);
    return _set;
  }
  Future<List<BehaveData>> _checkIfBehave() async {
    var _api = await Network().getList("mobile_behave");
    _data = behaveDataFromJson(_api);
    // print(_api);
    return _data;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _checkIfBehave(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_data == null || _set == null ) {
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
                            color: kBlueColor,
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
                                  text: 'รายการประจำปีการศึกษาจำนวน : 0 รายการ\n',
                                  style: TextStyle(
                                    fontSize: (16),
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
                    height: 170,
                    child: new Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: CustomShape(),
                          child: Container(
                            height: 170,
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          height: 120,
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (15),
                          ),
                          decoration: BoxDecoration(
                            color: kOrange2Colors,
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
                                  text: 'รายการในภาคเรียนมีจำนวน : '+ _data.length.toString()+' รายการ\n',
                                  style: TextStyle(
                                    fontSize: (16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "คะแนนเต็ม : " +
                                      _set.full.toString() +
                                      ' คะแนน\n',
                                  style: TextStyle(
                                    fontSize: (16),
                                  ),
                                ),
                                TextSpan(
                                  text: "คะแนน : " +
                                      _set.sumcp.toString() +
                                      ' คะแนน\n',
                                  style: TextStyle(
                                    fontSize: (16),
                                  ),
                                ),
                                TextSpan(
                                  text: "คะแนนคงเหลือ : " +
                                      _set.tolet.toString() +
                                      ' คะแนน\n',
                                  style: TextStyle(
                                    fontSize: (16),
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Expanded(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                       TextSpan(
                                          text: DateFormat.yMMMMd()
                                                  .formatInBuddhistCalendarThai(
                                                      result[index].createdAt) +
                                              "\n",
                                          style: TextStyle(
                                            color: kTextColor2,
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result[index].cpStatus +
                                              '/' +  "\n",

                                          style: TextStyle(
                                            color: kTextColor.withOpacity(.8),
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result[index].cpName ,
                                          style: TextStyle(
                                            color: kTextColor2.withOpacity(.8),
                                            fontSize: 15,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                                  Text(
                                    result[index].cpPoints.toString(),
                                    style: kHeadingextStyle.copyWith(
                                      color: result[index].cpPoints > 0 ?
                                      kGreenColor.withOpacity(.50) :
                                      kRedColors.withOpacity(.50),
                                      fontSize: 25,
                                    ),
                                  ),
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
