class UserModel {
  String id;
  String email;
  String password;
  String conformPassword;
  String fullName;
  String phoneNumber;
  UserModel(
      {required this.id,
        required this.email,
        required this.password,
        required this.fullName,
        required this.phoneNumber,
        required this.conformPassword});

  factory UserModel.fromjson(
      Map<String, dynamic> json, {required String deleteId}
      ) {
    return UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        conformPassword: json["conformPassword"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"]);
  }
  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "email": email,
      "password": password,
      "conformPassword": conformPassword,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
    };
  }
}
