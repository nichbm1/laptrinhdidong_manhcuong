class User {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String phone;
  String avatar;
  String address;
  int roleid;
  String status;
  int provinceid;
  int districtid;
  int wardid;
  String provincename;
  String districtname;
  String wardname;
  String birthday;
  User({
    this.id = 0,
    this.firstname = "",
    this.lastname = "",
    this.username = "",
    this.email = "",
    this.phone = "",
    this.avatar = "",
    this.address = "",
    this.roleid = 4,
    this.status = 'Active',
    this.provinceid = 0,
    this.districtid = 0,
    this.wardid = 0,
    this.provincename = "",
    this.districtname = "",
    this.wardname = "",
    this.birthday = "",
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['first_name'] ?? "",
      lastname: json['last_name'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      address: json['address'] ?? "",
      roleid: json['role_id'] ?? 4,
      status: json['status'] ?? "",
      provinceid: json['provinceid'] ?? 0,
      districtid: json['districtid'] ?? 0,
      wardid: json['wardid'] ?? 0,
      provincename: json['provincename'] ?? "",
      districtname: json['districtname'] ?? "",
      wardname: json['wardname'] ?? "",
      birthday: json['birthday'] ?? "",
    );
  }
  factory User.fromUser(User user) {
    return User(
      id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      username: user.username,
      email: user.email,
      phone: user.phone,
      avatar: user.avatar,
      address: user.address,
      roleid: user.roleid,
      status: user.status,
      provinceid: user.provinceid,
      districtid: user.districtid,
      wardid: user.wardid,
      provincename: user.provincename,
      districtname: user.districtname,
      wardname: user.wardname,
      birthday: user.birthday,
    );
  }
  factory User.clearInfo() {
    return User(
      id: 0,
      firstname: "",
      lastname: "",
      username: "",
      email: "",
      phone: "",
      avatar: "",
      address: "",
      roleid: 0,
      status: "",
      provinceid: 0,
      districtid: 0,
      wardid: 0,
      provincename: "",
      districtname: "",
      wardname: "",
      birthday: "",
    );
  }
}
