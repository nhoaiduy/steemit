import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:steemit/util/path/services_path.dart';
import 'package:uuid/uuid.dart';


final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<String> savePostImages(File file, String postId) async {
    try {
      final response = await _storage
          .ref()
          .child(ServicePath.post)
          .child(postId)
          .child(_uuid.v1())
          .putFile(file);
      return await response.ref.getDownloadURL();
    } on FirebaseException {
      rethrow;
    }
  }
}
