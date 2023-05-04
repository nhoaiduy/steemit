import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';
import 'package:steemit/generated/l10n.dart';

part 'post_controller_state.dart';

class PostControllerCubit extends Cubit<PostControllerState> {
  PostControllerCubit() : super(PostControllerInitial());

  final PostRepository _postRepository = PostRepository();

  Future<void> create(
      {required String content,
      required List<File> images,
      required BuildContext context}) async {
    LoadingCoverController.instance.common(context);
      {required String content, required List<File> images}) async {
    if (content.isEmpty && images.isEmpty) {
      emit(PostControllerFailure(S.current.txt_create_empty_post));
      return;
    }

    final response =
        await _postRepository.createPost(content: content, images: images);

    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }

    emit(PostControllerSuccess());
  }
}
