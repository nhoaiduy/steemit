import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/model/notification_model.dart';
import 'package:steemit/util/enum/gender_enum.dart';
import 'package:steemit/util/helper/gender_helper.dart';

class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  List<String>? savedPosts;
  List<ActivityModel>? activities;
  List<NotificationModel>? notifications;
  Gender? gender;
  String? bio;
  String? token;
  String? avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.savedPosts,
      this.activities,
      this.notifications,
      this.gender,
      this.bio,
      this.token,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    savedPosts = json["savedPosts"] != null
        ? (json["savedPosts"] as List).map((e) => e.toString()).toList()
        : List.empty(growable: true);
    activities = json["activities"] != null
        ? (json["activities"] as List)
            .map((e) => ActivityModel.fromJson(e))
            .toList()
        : List.empty(growable: true);
    notifications = json["notifications"] != null
        ? (json["notifications"] as List)
            .map((e) => NotificationModel.fromJson(e))
            .toList()
        : List.empty(growable: true);
    if (json["gender"] != null) {
      gender = GenderHelper.mapStringToEnum(json["gender"]);
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
    data["savedPosts"] = savedPosts;
    data["activities"] = activities;
    data["notifications"] = notifications;
    data['gender'] =
        gender != null ? GenderHelper.mapEnumToString(gender!) : null;
    data['bio'] = bio;
    data['token'] = token;
    data['avatar'] = avatar;
    return data;
  }
}
