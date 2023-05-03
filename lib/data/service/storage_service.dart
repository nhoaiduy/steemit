import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:steemit/util/path/services_path.dart';

final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
}
