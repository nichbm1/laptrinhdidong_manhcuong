import 'package:app_sv/model/student.dart';
import 'package:app_sv/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  static final Profile _instance = Profile._internal();
  // ignore: unused_element
  Profile._internal({this.token = ""});
  factory Profile() {
    return _instance;
  }
  late SharedPreferences _pref;
  late String token;
  Student student = Student();
  User user = User();
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
    token = "";
  }

  Future<void> setUsernamePassword(String username, String password) async {
    _pref.setString("username", username);
    _pref.setString("password", password);
  }

  Future<void> clearUsernamePassword() async {
    _pref.setString("username", '');
    _pref.setString("password", '');
  }

  String get username => _pref.getString('username') ?? '';
  String get password => _pref.getString('password') ?? '';
}
