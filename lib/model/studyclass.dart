class StudyClass {
  int idLop;
  String tenLop;
  int idKhoa;
  int status;
  StudyClass(
      {this.idLop = 0, this.tenLop = "", this.idKhoa = 0, this.status = 0});
  factory StudyClass.fromJson(Map<String, dynamic> json) {
    return StudyClass(
        idLop: json['id'],
        tenLop: json['ten'],
        idKhoa: json['idkhoa'],
        status: json['trangthai']);
  }
  factory StudyClass.fromStudyClass(StudyClass studyClass) {
    return StudyClass(
        idLop: studyClass.idLop,
        tenLop: studyClass.tenLop,
        idKhoa: studyClass.idKhoa,
        status: studyClass.status);
  }
}

class SV {
  String mssv;
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  SV({this.mssv = '', this.first_name = ''});
  factory SV.fromJson(Map<String, dynamic> json) {
    return SV(
      mssv: json['mssv'] ?? '',
      first_name: json['first_name'] ?? '',
    );
  }
}
