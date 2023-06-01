import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(ActivitiesInitial());

  Future<void> getData() async {
    final response = await UserRepository().getActivities();
    if (response.isLeft) {
      emit(ActivitiesFailure());
      return;
    }

    emit(ActivitiesSuccess(response.right
      ..sort(
          (a, b) => b.createdAt!.toDate().compareTo(a.createdAt!.toDate()))));
  }

  void clean() => emit(ActivitiesInitial());
}
