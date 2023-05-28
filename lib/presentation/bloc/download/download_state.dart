part of 'download_cubit.dart';

abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadDownloading extends DownloadState {}

class DownloadIFailure extends DownloadState {}

class DownloadSuccess extends DownloadState {}
