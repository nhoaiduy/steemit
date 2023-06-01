import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  Future<void> getData() async {
    final response = await UserRepository().getCurrentUser();
    if (response.isLeft) {
      emit(MeFailure(response.left));
      return;
    }
    emit(MeSuccess(response.right));
  }
}
