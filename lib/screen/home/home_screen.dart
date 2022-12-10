import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/convert/ProfileData.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/providers/profile_provider.dart';
import 'package:student_app/screen/about/about_screen.dart';
import 'package:student_app/screen/announcement/announcement.dart';
import 'package:student_app/screen/behave/behave.dart';
import 'package:student_app/screen/leave/leave.dart';
import 'package:student_app/screen/login.dart';
import 'package:student_app/screen/timeattendance/timeattendance.dart';
import 'package:student_app/utilities/constants.dart';
// import 'package:sweetalert/sweetalert.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetStudent(),
    );
  }
}

class GetStudent extends StatefulWidget {
  @override
  _GetStudentState createState() => _GetStudentState();
}

class _GetStudentState extends State<GetStudent> {
  ProfileData _profileData;
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<ProfileData> _checkIfLoggedIn() async {
    var _resule = await Network().getDataCheck("user");
    if (_resule != null) {
      _profileData = profileDataFromJson(_resule);
      ProfileData statement = ProfileData(
        schoolName: _profileData.schoolName,
        photo: _profileData.photo,
        className: _profileData.className,
        studentCode: _profileData.studentCode,
        semesters: _profileData.semesters,
        fullName: _profileData.fullName,
      );
      var provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.addProfile(statement);
      return _profileData;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _checkIfLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 350,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: CustomShape(),
                            child: Container(
                              height: 230,
                              color: kPrimaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      // left side padding is 40% of total width
                                      left: MediaQuery.of(context).size.width *
                                          .30,
                                      top: 20,
                                      right: 20,
                                    ),
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFFFFFF),
                                          Color(0xFFECECEC),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 33,
                                          color: Color(0xFFD3D3D3)
                                              .withOpacity(.84),
                                        ),
                                      ],
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                            _profileData.fullName ??=
                                                '' ,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: kTextColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            // '' ,
                                            '\n' + 'รหัสนักเรียน ' +
                                                _profileData.studentCode +
                                                '\n' ,
                                            style: TextStyle(color: kTextColor),
                                          ),
                                          TextSpan(
                                            text:
                                            // '' ,
                                            _profileData.className + '\n',
                                            style: TextStyle(color: kTextColor),
                                          ),
                                          TextSpan(
                                            text:
                                            // '' ,
                                                _profileData.schoolName + '\n',
                                            style: TextStyle(color: kTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      // 'http://clickcloudschool.com/image/student/cbp/07591.jpg',
                                      _profileData.photo,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Text("error"),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80,
                                        height: 115,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(80, 115)),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 0),
                          //20
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -130.0, 0.0),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "รายการ \n",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ChapterCard(
                              name: "ข้อมูลของฉัน",
                              chapterNumber: 6,
                              tag: "About Me",
                              img: "assets/icons/clipboard.png",
                              press: () => {_about(context)},
                            ),
                            ChapterCard(
                              name: "เวลามาเรียน",
                              chapterNumber: 2,
                              tag: "ตรวจสอบเวลาเรียน",
                              img: "assets/icons/schedule.png",
                              press: () => {_timeattendance(context)},
                            ),
                            ChapterCard(
                              name: "วันลา",
                              chapterNumber: 3,
                              tag: "ตรวจสอบวันลา",
                              img: "assets/icons/organize.png",
                              press: () => {_leave(context)},
                            ),
                            ChapterCard(
                              name: "คะแนนความประพฤติ",
                              chapterNumber: 1,
                              tag: "ตรวจสอบคะแนนความประพฤติ",
                              img: 'assets/icons/satisfaction.png',
                              press: () => {_behave(context)},
                            ),
                            ChapterCard(
                              name: "บันทึกถึงผู้เรียน",
                              chapterNumber: 4,
                              tag: "บันทึกถึงผู้เรียน",
                              img: "assets/icons/calendar.png",
                              press: () => {_announcement(context)},
                            ),
                            ChapterCard(
                              name: "ยอดเงินคงเหลือ",
                              chapterNumber: 1,
                              tag: "ระบบโรงอาหาร",
                              img: 'assets/icons/wallet.png',
                              press: () => {_error(context)},
                            ),
                            ChapterCard(
                              name: "ประวัติการใช้งานห้องสมุด",
                              chapterNumber: 1,
                              tag: "ระบบห้องสมุด",
                              img: 'assets/icons/testing.png',
                              press: () => {_error(context)},
                            ),
                            ChapterCard(
                              name: "การแจ้งเตือน",
                              chapterNumber: 6,
                              tag: "Notification",
                              img: "assets/icons/notification.png",
                              press: () {},
                            ),
                            ChapterCard(
                              name: "Version",
                              chapterNumber: 6,
                              tag: "Winning is what",
                              img: "assets/icons/development.png",
                              press: () {},
                            ),
                            ChapterCard(
                              name: "Logout",
                              chapterNumber: 5,
                              tag: "Logout form system",
                              img: "assets/icons/logout.png",
                              press: () => {_logout(context)},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return LinearProgressIndicator();
        });
  }
}

void _logout(BuildContext context) async {
  // DefaultCacheManager manager = new DefaultCacheManager();
  // manager.emptyCache(); //clear cache
  await Network().clearToken();
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Login()));
}

void _about(BuildContext context) async {
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => AboutScreen()));
}

void _timeattendance(BuildContext context) async {
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Timeattendance()));
}
void _leave(BuildContext context) async {
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Leave()));
}
void _behave(BuildContext context) async {
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Behave()));
}
void _announcement(BuildContext context) async {
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Announcement()));
}

void _error(BuildContext context) async {
  // SweetAlert.show(context,
  //     title: "เกิดข้อผิดพลาด",
  //     subtitle: 'ขออภัยท่านไม่ได้ใช้ระบบ',
  //     style: SweetAlertStyle.error);
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

class ChapterCard extends StatelessWidget {
  final String name;
  final String tag;
  final String img;
  final int chapterNumber;
  final Function press;
  const ChapterCard({
    Key key,
    this.name,
    this.tag,
    this.img,
    this.chapterNumber,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        margin: EdgeInsets.only(bottom: 16),
        width: size.width - 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 33,
              color: Color(0xFFD3D3D3).withOpacity(.84),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 25.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(img),
                  )),
            ),
            SizedBox(width: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$name \n",
                    style: TextStyle(
                      fontSize: 16,
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: tag,
                    style: TextStyle(color: kTextColor),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onPressed: press,
            )
          ],
        ),
      ),
    );
  }
}
