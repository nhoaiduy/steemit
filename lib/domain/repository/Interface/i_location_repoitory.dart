import 'package:either_dart/either.dart';
import 'package:steemit/data/model/location_model.dart';

abstract class LocationRepositoryInterface {
  Future<Either<String, List<LocationModel>>> getLocationData(String text);
}
