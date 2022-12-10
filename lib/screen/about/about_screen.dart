import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/convert/ProfileData.dart';
import 'package:student_app/network_utils/api.dart';
import 'package:student_app/providers/profile_provider.dart';
import 'package:student_app/screen/login.dart';
import 'package:student_app/utilities/constants.dart';

import '../../size_config.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ข้อมูลของฉัน",
          style: kLabelStyle,
        ),
      ),
      body: GetStudent(),
    );
  }
}

class GetStudent extends StatefulWidget {
  @override
  _GetStudentState createState() => _GetStudentState();
}

class _GetStudentState extends State<GetStudent> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ProfileData>(context,listen: false).getProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ProfileProvider provider, Widget child) {
          var count = provider.profile.length;
          ProfileData data = provider.profile[0];
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 35),
              ),
            );
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 160,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: CustomShape(),
                            child: Container(
                              height: 145,
                              color: kPrimaryColor,
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: data.photo??="https://clickcloudschool.com/image/default/profile1.png",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Text("error"),
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 100,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.elliptical(100, 150)),
                                      border: Border.all(color: Colors.white, width: 4),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20), //20
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ChapterCard(
                            name: "ชื่อสกุล",
                            chapterNumber: 6,
                            tag: data.fullName??="",
                            img: "assets/images/About_Me.png",
                            press: () {},
                          ),
                          ChapterCard(
                            name: "รหัสนักเรียน",
                            chapterNumber: 2,
                            tag: data.studentCode??="",
                            img: "assets/images/Time.png",
                            press: () {},
                          ),
                          ChapterCard(
                            name: "ชั้นเรียน",
                            chapterNumber: 3,
                            tag: data.className??="",
                            img: "assets/images/Enroll.png",
                            press: () {},
                          ),
                          ChapterCard(
                            name: "โรงเรียน",
                            chapterNumber: 1,
                            tag: data.schoolName??="",
                            img: 'assets/images/Money.png',
                            press: () {},
                          ),
                          ChapterCard(
                            name: "เบอร์โทร",
                            chapterNumber: 6,
                            tag: "ไม่ระบุ",
                            img: "assets/images/Noti.png",
                            press: () {},
                          ),
                          ChapterCard(
                            name: "Calendar",
                            chapterNumber: 4,
                            tag: "Test system Calendar",
                            img: "assets/images/Calendar.png",
                            press: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

void _logout(BuildContext context) async {
  await Network().clearToken();
  await Navigator.push(
      context, new MaterialPageRoute(builder: (context) => Login()));
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
    double defaultSize = SizeConfig.defaultSize;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              // SvgPicture.asset(img),
              SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$name \n \n",
                      style: TextStyle(
                        fontSize: 16,
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: tag,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
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
