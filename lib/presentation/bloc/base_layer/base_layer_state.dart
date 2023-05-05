part of 'base_layer_cubit.dart';

@immutable
abstract class BaseLayerState {}

class BaseLayerInitial extends BaseLayerState {}

class LanguageState extends BaseLayerState {
  final dynamic locale;
  final dynamic languageKey;

  LanguageState(this.locale, this.languageKey);
}
