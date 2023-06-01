part of 'activity_controller_cubit.dart';

@immutable
abstract class ActivityControllerState {}

class ActivityControllerInitial extends ActivityControllerState {}

class ActivityControllerFailure extends ActivityControllerState {}

class ActivityControllerSuccess extends ActivityControllerState {}
