import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/util/enum/media_enum.dart';

class PostModel {
  String? id;
  String? userId;
  UserModel? user;
  String? content;
  String? location;
  List<MediaModel>? medias;
  List<String>? likes;
  List<CommentModel>? comments;
  Timestamp? createAt;
  Timestamp? updatedAt;
  bool? delete;

  PostModel(
      {this.id,
      this.userId,
      this.user,
      this.content,
      this.medias,
      this.location,
      this.likes,
      this.comments,
      this.createAt,
      this.updatedAt,
      this.delete});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    user = json["user"] != null ? UserModel.fromJson(json["user"]) : null;
    content = json["content"];
    location = json["location"];
    medias = json["medias"] != null
        ? (json["medias"] as List).map((e) => MediaModel.fromJson(e)).toList()
        : List.empty();
    likes = json["likes"] != null
        ? (json["likes"] as List).map((e) => e.toString()).toList()
        : List.empty();
    comments = json["comments"] != null
        ? (json["comments"] as List)
            .map((e) => CommentModel.fromJson(e))
            .toList()
        : List.empty();
    createAt = json["createAt"];
    updatedAt = json["updatedAt"];
    delete = json["delete"] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "content": content,
      "medias": medias?.map((e) => e.toJson()).toList(),
      "location": location,
      "likes": likes,
      "comments": comments?.map((e) => e.toJson()).toList(),
      "createdAt": createAt,
      "updatedAt": updatedAt,
      "delete": delete
    };
  }
}

class CommentModel {
  String? id;
  String? content;
  String? userId;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  UserModel? user;

  CommentModel(
      this.id, this.content, this.userId, this.createdAt, this.updatedAt);

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    content = json["content"];
    userId = json["userId"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "userId": userId,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

class MediaModel {
  String? id;
  String? name;
  MediaEnum? type;
  String? url;

  MediaModel({this.id, this.name, this.type, this.url});

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = MediaEnum.values[json["type"]];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "type": type!.index, "url": url};
  }
}
