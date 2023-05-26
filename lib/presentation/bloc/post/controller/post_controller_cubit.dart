import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';

part 'post_controller_state.dart';

class PostControllerCubit extends Cubit<PostControllerState> {
  PostControllerCubit() : super(PostControllerInitial());

  final PostRepository _postRepository = PostRepository();

  Future<void> create(
      {required String content,
      required List<XFile> images,
      required BuildContext context,
      String? location}) async {
    LoadingCoverController.instance.common(context);
    if (content.isEmpty && images.isEmpty) {
      emit(PostControllerFailure(S.current.txt_create_empty_post));
      return;
    }

    final response = await _postRepository.createPost(
        content: content, medias: images, location: location);

    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }

    emit(PostControllerSuccess());
  }

  Future<void> save({required String postId}) async {
    final response = await _postRepository.savePost(postId: postId);
    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }
    emit(PostControllerSuccess());
  }

  Future<void> unSave({required String postId}) async {
    final response = await _postRepository.unSavePost(postId: postId);
    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }
    emit(PostControllerSuccess());
  }

  Future<void> like({required String postId}) async {
    final response = await _postRepository.likePost(postId: postId);
    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }
    emit(PostControllerSuccess());
  }

  Future<void> unLike({required String postId}) async {
    final response = await _postRepository.unLikePost(postId: postId);
    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }
    emit(PostControllerSuccess());
  }

  Future<void> delete({required String postId}) async {
    final response = await _postRepository.deletePost(postId: postId);
    if (response.isLeft) {
      emit(PostControllerFailure(response.left));
      return;
    }
    emit(PostControllerSuccess());
  }

  void clean() => emit(PostControllerInitial());
}
