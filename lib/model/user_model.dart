class UserModel {
  String? department, email, mobile, name, password,access;

  UserModel(
      {this.department, this.email, this.mobile, this.name, this.password,this.access});

  factory UserModel.mapToModel(Map m1) {
    return UserModel(
        department: m1['department'],
        email: m1['email'],
        mobile: m1['mobile'],
        name: m1['name'],
        access: m1['access'],
        password: m1['password']);
  }
}
