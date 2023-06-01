part of 'activities_cubit.dart';

@immutable
abstract class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesFailure extends ActivitiesState {}

class ActivitiesSuccess extends ActivitiesState {
  final List<ActivityModel> activities;

  ActivitiesSuccess(this.activities);
}
