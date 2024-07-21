class UserModel {
  String? email, mobile, name, password,uid;
  List? department, designation;

  UserModel(
      {this.department,
      this.email,
      this.mobile,
      this.name,
      this.password,
      this.uid,
      this.designation});

  factory UserModel.mapToModel(Map m1) {
    return UserModel(
      department: m1['department'] ?? [],
      email: m1['email'] ?? '',
      mobile: m1['mobile'] ?? '',
      name: m1['name'] ?? '',
      designation: m1['designation'] ?? [],
      password: m1['password'] ?? '',
      uid: m1['uid']??''
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'uid': uid,
      'department': department,
      'designation': designation,
    };
  }
}
