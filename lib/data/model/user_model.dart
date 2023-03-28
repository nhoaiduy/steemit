

class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  String? avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}
