import 'package:either_dart/either.dart';
import 'package:steemit/data/service/storage_service.dart';
import 'package:steemit/domain/repository/Interface/i_download.dart';

class DownloadRepository extends DownloadRepositoryInterface {
  @override
  Future<Either<String, void>> download(String url, String name) async {
    try {
      final response = await storageService.downloadFile(url, name);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
