
import 'package:flutter/foundation.dart';
import 'package:student_app/convert/ProfileData.dart';

class ProfileProvider with ChangeNotifier{
  List<ProfileData> profile = [];

  List<ProfileData> getProfile(){
    return profile;
  }

  void addProfile(ProfileData statement) {
    profile.insert(0, statement);
    notifyListeners();
  }

  void removeAll(){
    profile.clear();
    notifyListeners();
  }

}


