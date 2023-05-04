import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/page/authentication/authentication_layer.dart';
import 'package:steemit/presentation/page/common/app_loading_page.dart';

class BaseLayer extends StatelessWidget {
  /// Base Layer: Setting app language
  const BaseLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseLayerCubit, BaseLayerState>(
      bloc: GetIt.instance.get<BaseLayerCubit>(),
      builder: (context, state) {
        if (state is LanguageState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            home: const AuthenticationLayerPage(),
          );
        }
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AppLoadingPage(),
        );
      },
    );
  }
}
