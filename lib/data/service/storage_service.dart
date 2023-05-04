import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:steemit/util/path/services_path.dart';

final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> savePostImages(File file, String postId) async {
    try {
      final response = await _storage
          .ref()
          .child(ServicePath.post)
          .child(postId)
          .putFile(file);
      return await response.ref.getDownloadURL();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> likePost(String postId, String userId, List likes) async {
    try {
      if(likes.contains(userId)){
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([userId])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([userId])
        });
      }
    } catch(e) {
      print(e.toString());
    }
  }
}
