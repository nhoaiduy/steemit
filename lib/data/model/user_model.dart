import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late Timestamp createdAt;
  late Timestamp updatedAt;
  String? avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.createdAt,
      required this.updatedAt,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['avatar'] = avatar;
    return data;
  }
}
