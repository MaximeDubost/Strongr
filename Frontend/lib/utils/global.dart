import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static const String SERVER_URL = "http://192.168.1.34:3000/api";
  //static const String SERVER_URL = "https://strongr-app.herokuapp.com/api";

  static SharedPreferences prefs;
  // static String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJjaHJpc3QudWxjZUBnbWFpbC5jb20iLCJ1c2VybmFtZSI6InVsY2UzMSIsImlhdCI6MTU5NDU2NDU5OH0.ipJfhmkLf0DEHGLlpnqOhd4kznjDkzt74fhjiV-_4Oc";

  /*static Future<String> getToken() async {
    print("In getToken() " + prefs.getString("token"));
    return prefs.getString("token");
  }

  static setStringDebug() async {
    prefs.setString("token",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJjaGlhcmEuYmVyYXJkaUBnbWFpbC5jb20iLCJ1c2VybmFtZSI6ImNiZXJhcmRpIiwiaWF0IjoxNTg2NjE5MDUzfQ.oqfUBj0NMrba1To3qLMEOEimuba8CxBGbdCpt_f9ZzU");
  }*/
}
