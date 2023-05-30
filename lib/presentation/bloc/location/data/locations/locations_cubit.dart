import 'package:bloc/bloc.dart';
import 'package:steemit/data/model/location_model.dart';
import 'package:steemit/domain/repository/Implement/location_repository_impl.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());

  Future<void> getData(String text) async {
    final response = await LocationRepository().getLocationData(text);
    if (response.isLeft) {
      emit(LocationsFailure());
      return;
    }
    emit(LocationsSuccess(response.right));
  }

  void clean() => emit(LocationsInitial());
}
