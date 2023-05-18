import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  late String id;
  late String type;
  late Timestamp time;
  late String postId;
  late String nameUserPost;
  String? images;


  ActivityModel(
      {required this.id,
        required this.type,
        required this.time,
        required this.postId,
        required this.nameUserPost,
        this.images,});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    type = json["type"];
    time = json["time"];
    postId = json["postId"];
    nameUserPost = json["nameUserPost"];
    images = json["images"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "time": time,
      "postId": postId,
      "nameUserPost": nameUserPost,
      "images": images,
    };
  }
}
