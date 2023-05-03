import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/user_model.dart';

class PostModel {
  String? id;
  String? userId;
  UserModel? user;
  String? content;
  List<String>? images;
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
      this.images,
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
    images = json["images"] != null
        ? (json["images"] as List).map((e) => e.toString()).toList()
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
      "user": user?.toJson(),
      "content": content,
      "images": images,
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
  Timestamp? createAt;
  Timestamp? updatedAt;

  CommentModel(
      this.id, this.content, this.userId, this.createAt, this.updatedAt);

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    content = json["content"];
    userId = json["userId"];
    createAt = json["createAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "userId": userId,
      "createdAt": createAt,
      "updatedAt": updatedAt,
    };
  }
}
