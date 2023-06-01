import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/util/enum/activity_enum.dart';

class ActivityModel {
  String? postId;
  PostModel? post;
  UserModel? user;
  ActivityEnum? type;
  Timestamp? createdAt;

  ActivityModel({this.postId, this.type, this.createdAt});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    postId = json["postId"];
    type = ActivityEnum.values[json["type"]];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    return {"postId": postId, "type": type!.index, "createdAt": createdAt};
  }
}
