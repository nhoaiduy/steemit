part of 'locations_cubit.dart';

abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class LocationsFailure extends LocationsState {}

class LocationsSuccess extends LocationsState {
  final List<LocationModel> locations;

  LocationsSuccess(this.locations);
}
