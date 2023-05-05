import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:steemit/domain/repository/Implement/language_repository_impl.dart';
import 'package:steemit/util/helper/language_helper.dart';

part 'base_layer_state.dart';

class BaseLayerCubit extends Cubit<BaseLayerState> {
  BaseLayerCubit() : super(BaseLayerInitial()) {
    setupLanguage();
  }

  setupLanguage() async {
    Locale? currentLocale = await LanguageHelper.getCurrentLocale();
    String? languageKey = await LanguageRepository().getLanguageKey();
    emit(LanguageState(currentLocale, languageKey));
  }

  changeLanguage({required BuildContext context, String? languageKey}) async {
    await LanguageRepository().changeLanguage(languageKey: languageKey);
    setupLanguage();
  }
}
