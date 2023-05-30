import 'package:either_dart/either.dart';
import 'package:steemit/data/model/location_model.dart';
import 'package:steemit/domain/repository/Interface/i_location_repoitory.dart';
import 'package:steemit/data/service/location_service.dart';

class LocationRepository extends LocationRepositoryInterface {
  @override
  Future<Either<String, List<LocationModel>>> getLocationData(
      String text) async {
    try {
      final response = await LocationAPI().getLocationData(text);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class LocationAPi {}
