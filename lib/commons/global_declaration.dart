import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;
int? allItemCount; //for navigation to top
String? token;

class Strings {
  static String ip = '/api/webmart';
  static String webMartUrl = 'http://182.93.85.199:8085/webmart';
  static String webMartUrlImageUrl = '$webMartUrl/images';
  static String login = '$ip/login';
  static String tabletSetup = '$ip/GetTabletSetup';
  static String validMAC = '$ip/ValidMAC';
}

List gender = [
  {
    "gender": "Male",
  },
  {
    "gender": "Female",
  },
];
List education = [
  {
    "education": "Schooling",
  },
  {
    "education": "High-School",
  },
  {
    "education": "Diploma",
  },
  {
    "education": "Graduate",
  },
  {
    "education": "Post-Graduate",
  },
];
