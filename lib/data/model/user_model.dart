class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late List<UserModel> followers;
  late List<UserModel> followings;
  String? bio;
  String? token;
  String? avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.followers,
      required this.followings,
      this.bio,
      this.token,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    if (json["followers"] != null) {
      followers = (json["followers"] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    } else {
      followers = List.empty(growable: true);
    }
    if (json["followings"] != null) {
      followings = (json["followings"] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    } else {
      followings = List.empty(growable: true);
    }
    token = json["token"];
    bio = json["bio"];
    avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['followings'] = followings;
    data['followers'] = followers;
    data['bio'] = bio;
    data['token'] = token;
    data['avatar'] = avatar;
    return data;
  }
}
