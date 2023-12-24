class Student {
  int idUser;
  String msSV;
  int idLop;
  String tenLop;
  int diem;
  int duyet;
  Student(
      {this.idUser = 0,
      this.msSV = "",
      this.idLop = 0,
      this.tenLop = "",
      this.diem = 0,
      this.duyet = 0});
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        idUser: json['iduser'],
        msSV: json['mssv'],
        idLop: json['idlop'],
        tenLop: json['lop'],
        diem: json['diem'],
        duyet: json['duyet']);
  }
  factory Student.fromStudent(Student student) {
    return Student(
        idUser: student.idUser,
        msSV: student.msSV,
        idLop: student.idLop,
        tenLop: student.tenLop,
        diem: student.diem,
        duyet: student.duyet);
  }
  factory Student.clearInfo() {
    return Student(
        idUser: 0, msSV: "", idLop: 0, tenLop: "", diem: 0, duyet: 0);
  }
}
