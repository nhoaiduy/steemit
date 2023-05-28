import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/page/authentication/authentication_layer.dart';
import 'package:steemit/presentation/page/common/app_loading_page.dart';
import 'package:steemit/util/style/base_color.dart';

class BaseLayer extends StatelessWidget {
  /// Base Layer: Setting app language
  const BaseLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseLayerCubit, BaseLayerState>(
      bloc: GetIt.instance.get<BaseLayerCubit>(),
      builder: (context, state) {
        if (state is LanguageState) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(scaffoldBackgroundColor: BaseColor.background),
              supportedLocales: S.delegate.supportedLocales,
              locale: state.locale,
              home: const AuthenticationLayerPage(),
            ),
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
