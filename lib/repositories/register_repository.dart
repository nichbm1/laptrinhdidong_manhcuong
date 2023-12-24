import 'package:app_sv/services/api_services.dart';

class RegisterRepository {
  final ApiServices api = ApiServices();
  Future<int> register(String username, String email, String password) async {
    int result = 2;
    final response = await api.registerUser(username, email, password);
    if (response != null && response.statusCode == 201) {
      if (response.data['requires_email_confirmation'] == true) {
        return 3;
      } else {
        return 4;
      }
    }
    return result;
  }
}
