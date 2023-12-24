class Course {
  int id;
  String tenhocphan;
  String tengv;
  Course({required this.id, required this.tenhocphan, required this.tengv});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      tenhocphan: json['tenhocphan'],
      tengv: json['tengv'],
    );
  }
}

class RegisterCourse {
  int id;
  int idsinhvien;
  int iduser;
  String tenhocphan;
  String tengv;
  RegisterCourse(
      {this.id = 0,
      this.iduser = 0,
      this.tenhocphan = '',
      this.tengv = '',
      this.idsinhvien = 0});
  factory RegisterCourse.fromJson(Map<String, dynamic> json) {
    return RegisterCourse(
      id: json['id'] ?? 0,
      iduser: json['iduser'] ?? 0,
      idsinhvien: json['idsinhvien'],
      tenhocphan: json['tenhocphan'] ?? '',
      tengv: json['tengv'] ?? '',
    );
  }
}
