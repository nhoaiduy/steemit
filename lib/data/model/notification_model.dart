import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/util/enum/activity_enum.dart';

class NotificationModel {
  String? id;
  String? userId;
  String? postId;
  ActivityEnum? type;
  Timestamp? createdAt;
  UserModel? user;

  NotificationModel(
      {this.id, this.userId, this.postId, this.type, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    postId = json["postId"];
    type = ActivityEnum.values[json["type"]];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "postId": postId,
      "type": type?.index,
      "createdAt": createdAt
    };
  }
}
