part of 'notification_controller_cubit.dart';

@immutable
abstract class NotificationControllerState {}

class NotificationControllerInitial extends NotificationControllerState {}

class NotificationControllerFailure extends NotificationControllerState {}

class NotificationControllerSuccess extends NotificationControllerState {}
