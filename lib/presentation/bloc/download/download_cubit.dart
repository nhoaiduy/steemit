import 'package:bloc/bloc.dart';
import 'package:steemit/domain/repository/Implement/download_repository_impl.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  Future<void> download(String url, String name) async {
    emit(DownloadDownloading());
    final response = await DownloadRepository().download(url, name);
    if (response.isLeft) {
      emit(DownloadIFailure());
      return;
    }

    emit(DownloadSuccess());
  }

  void clean() => emit(DownloadInitial());
}
