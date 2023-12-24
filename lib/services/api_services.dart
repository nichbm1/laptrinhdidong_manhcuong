import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:app_sv/model/profile.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();
  ApiServices._internal();
  factory ApiServices() {
    return _instance;
  }

  // ignore: non_constant_identifier_names
  final url_login = "https://chocaycanh.club/public/api/login";
  // ignore: non_constant_identifier_names
  final url_resgister = "https://chocaycanh.club/public/api/register";
// ignore: non_constant_identifier_names
  final url_forgot = "https://chocaycanh.club/public/api/password/remind";
  late Dio _dio;

  void initialize() {
    _dio = Dio(BaseOptions(responseType: ResponseType.json));
  }

  Future<Response?> loginUser(String username, String password) async {
    Map<dynamic, dynamic> param = {
      "username": username,
      "password": password,
      "device_name": "android"
    };
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    try {
      final response = await _dio.post(url_login,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  Future<Response?> registerUser(
      String username, String email, String password) async {
    Map<dynamic, dynamic> param = {
      "username": username,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "tos": "true"
    };
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    try {
      final response = await _dio.post(url_resgister,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 201) {
        // ignore: avoid_print
        print(response.data);
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> forgotPassword(String email) async {
    Map<dynamic, dynamic> param = {
      "email": email,
    };
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    try {
      final response = await _dio.post(url_forgot,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> getStudentInfo() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    String infoURL = "https://chocaycanh.club/api/sinhvien/info";
    try {
      final response =
          await _dio.get(infoURL, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> getUserInfo() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    String infoURL = "https://chocaycanh.club/api/me";
    try {
      final response =
          await _dio.get(infoURL, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> getClassList() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    String infoURL = "https://chocaycanh.club/api/lophoc/ds";
    try {
      final response =
          await _dio.get(infoURL, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> getStudentList(int id) async {
    var urlgetdssv = 'https://chocaycanh.club/api/lophoc/dssinhvien';
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      'Authorization': 'Bearer ${Profile().token}',
      "Accept": "application/json",
    };
    Map<String, dynamic> param = {
      "idlophoc": Profile().student.idLop,
    };
    try {
      var response = await _dio.post(
        urlgetdssv,
        data: jsonEncode(param),
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Response?> getRegisterCourse() async {
    const urlInfo = 'https://chocaycanh.club/api/hocphan/dsmechung';
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      'Authorization': 'Bearer ${Profile().token}',
      "Accept": "application/json",
    };
    try {
      var response = await _dio.get(
        urlInfo,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Response?> registerCourse(int id) async {
    final urlInfo = 'https://chocaycanh.club/api/hocphan/dangky?idhocphan=$id';
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      'Authorization': 'Bearer ${Profile().token}',
      "Accept": "application/json",
    };
    try {
      var response = await _dio.post(
        urlInfo,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Response?> getCourseList() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    String infoURL = "https://chocaycanh.club/api/hocphan/ds";
    try {
      final response =
          await _dio.get(infoURL, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  Future<Response?> updateProfile() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    Profile profile = Profile();
    Map<dynamic, dynamic> param = {
      "first_name": profile.user.firstname,
      "last_name": profile.user.lastname,
      "phone": profile.user.phone,
      "address": profile.user.address,
      "provinceid": profile.user.provinceid,
      "districtid": profile.user.districtid,
      "wardid": profile.user.wardid,
      "provincename": profile.user.provincename,
      "districtname": profile.user.districtname,
      "wardname": profile.user.wardname,
      "street": profile.user.address,
      "birthday": profile.user.birthday,
    };
    String infoURL = "https://chocaycanh.club/api/me/details";
    try {
      final response = await _dio.patch(infoURL,
          options: Options(headers: headers), data: jsonEncode(param));
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response);
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error: $e");
        // ignore: avoid_print
        print(e.message);
        // ignore: avoid_print
        print(e.error);
        // ignore: avoid_print
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> registerClass() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    Profile profile = Profile();
    Map<dynamic, dynamic> param = {
      "id": profile.student.idLop,
      "mssv": profile.student.msSV
    };
    String infoURL = "https://chocaycanh.club/api/lophoc/dangky";
    try {
      final response = await _dio.post(infoURL,
          options: Options(headers: headers), data: jsonEncode(param));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error: $e");
      }
    }
    return null;
  }

  Future<List<dynamic>?> getListCity() async {
    String apiUrl = "https://chocaycanh.club/api/getjstinh";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<dynamic>?> getListDistrict(int id) async {
    String apiUrl = "https://chocaycanh.club/api/getjshuyen?id=$id";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<dynamic>?> getListWard(int id) async {
    String apiUrl = "https://chocaycanh.club/api/getjsxa?id=$id";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${Profile().token}",
      "Accept": "application/json",
    };
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> updateNewAvatar(File imageFile) async {
    Profile profile = Profile();
    String apiUrl = "https://chocaycanh.club/api/me/avatar";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${profile.token}",
      "Accept": "application/json",
    };
    FormData formData = FormData.fromMap(
        {'file': await MultipartFile.fromFile(imageFile.path)});
    await _dio.post(apiUrl, data: formData, options: Options(headers: headers));
  }
}
