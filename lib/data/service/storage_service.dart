import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/util/enum/media_enum.dart';
import 'package:steemit/util/path/services_path.dart';
import 'package:uuid/uuid.dart';

final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();
  final HttpClient client = HttpClient();

  Future<MediaModel> saveMedia(XFile file, String postId) async {
    try {
      final MediaModel mediaModel = MediaModel();
      mediaModel.id = _uuid.v1();
      final response = await _storage
          .ref()
          .child(ServicePath.post)
          .child(postId)
          .child(mediaModel.id!)
          .putFile(File(file.path));
      mediaModel.name = file.name;
      final type = (await response.ref.getMetadata()).contentType!;
      mediaModel.type =
          MediaEnum.values.byName(type.substring(0, type.indexOf("/")));
      mediaModel.url = await response.ref.getDownloadURL();
      return mediaModel;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> downloadFile(String url, String name) async {
    try {
      var request = await client.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getDirectory())!.path;
      File file = File('$dir/$name');
      await file.writeAsBytes(bytes);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<Directory?> getDirectory() async {
    bool dirDownloadExists = true;
    if (Platform.isIOS) {
      return await getDownloadsDirectory();
    }
    Directory directory = Directory("/storage/emulated/0/Download");
    dirDownloadExists = await directory.exists();
    if (!dirDownloadExists) {
      directory = Directory("/storage/emulated/0/Downloads");
    }
    return directory;
  }
}
