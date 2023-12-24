import 'package:app_sv/model/course.dart';
import 'package:app_sv/services/api_services.dart';

class RegisterCourseRopository {
  final ApiServices api = ApiServices();
  int result = 1;
  Future<int> registerCourse(int id) async {
    var response = await api.registerCourse(id);
    if (response != null && response.statusCode == 200) {
      result = 3;
    } else {
      result = 2;
    }
    return result;
  }

  Future<List<RegisterCourse>> getRegisterCourse() async {
    List<RegisterCourse> registerCourse = [];
    var response = await api.getRegisterCourse();
    if (response != null && response.statusCode == 200) {
      var data = response.data['data'];
      for (var item in data) {
        var json = RegisterCourse.fromJson(item);
        registerCourse.add(json);
      }
    }
    return registerCourse;
  }
}
