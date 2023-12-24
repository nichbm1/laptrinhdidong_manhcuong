import 'package:app_sv/model/profile.dart';
import 'package:app_sv/services/api_services.dart';

class LoginRepository {
  final ApiServices api = ApiServices();
  Future<Profile> login(String username, String password) async {
    Profile profile = Profile();
    final response = await api.loginUser(username, password);
    if (response != null && response.statusCode == 200) {
      profile.token = response.data['token'];
      profile.setUsernamePassword(username, password);
    } else {
      profile.token = "";
    }
    return profile;
  }
}
