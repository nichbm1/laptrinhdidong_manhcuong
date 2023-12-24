import 'dart:convert';

import 'package:app_sv/model/studyclass.dart';
import 'package:app_sv/services/api_services.dart';

class StudyClassRepository {
  Future<List<StudyClass>> getListClass() async {
    List<StudyClass> list = [];
    list.add(StudyClass(tenLop: "--Choose--"));
    final response = await ApiServices().getClassList();
    if (response != null) {
      var data = response.data['data'];
      for (var item in data) {
        var studyClass = StudyClass.fromJson(item);
        list.add(studyClass);
      }
    }
    return list;
  }

  Future<List<SV>> getStudentList(int id) async {
    List<SV> list = [];
    var response = await ApiServices().getStudentList(id);
    if (response != null && response.data != null) {
      var data = response.data;
      List<dynamic> jsonList = json.decode(data);
      list = jsonList.map((json) => SV.fromJson(json)).toList();
      return list;
    }
    return [];
  }
}
