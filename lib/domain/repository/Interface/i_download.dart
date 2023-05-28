import 'package:either_dart/either.dart';

abstract class DownloadRepositoryInterface {
  Future<Either<String, void>> download(String url, String name);
}
