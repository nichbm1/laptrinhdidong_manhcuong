import 'package:app_sv/model/course.dart';
import 'package:app_sv/model/profile.dart';
import 'package:app_sv/repositories/registercourse_repository.dart';
import 'package:flutter/foundation.dart';

class CourseViewModel with ChangeNotifier {
  String message = '';
  int status = 0;
  RegisterCourseRopository registerCourseRepo = RegisterCourseRopository();
  void resetStatus() {
    status = 0;
    notifyListeners();
  }

  Future<void> registerCourse(int id) async {
    status = 3;
    notifyListeners();
    try {
      var result = await registerCourseRepo.registerCourse(id);
      if (result == 3) {
        status = 3;
        message = 'Đăng ký thành công';
        notifyListeners();
      } else {
        message = "Đăng ký  thất bại !";
        status = 2;
        notifyListeners();
      }
    } catch (e) {
      status = 1;
      // ignore: avoid_print
      print(e);
    }
  }

  Future<List<RegisterCourse>> getRegisterCourse() async {
    notifyListeners();
    try {
      var response = await registerCourseRepo.getRegisterCourse();
      List<RegisterCourse> allCourses = response;
      final filteredList = allCourses
          .where((hocPhan) => hocPhan.idsinhvien == Profile().user.id)
          .toList();
      return filteredList;
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return [];
    }
  }
}
