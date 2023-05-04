import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/data/model/language.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/tile/tile_widget.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseLayerCubit, BaseLayerState>(
        bloc: getIt.get<BaseLayerCubit>(),
        builder: (context, state) {
          if (state is LanguageState) {
            return Column(children: [
              Header.background(
                  content: S.current.lbl_change_language,
                  suffixContent: S.current.btn_done,
                  onSuffix: () {
                    Navigator.pop(context);
                  }),
              _buildBody(state),
            ]);
          }
          return const SizedBox.shrink();
        });
  }

  Widget _buildBody(LanguageState state) {
    return Expanded(
      child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
          child: Column(
              children: List.generate(Language.languages().length, (index) {
            final language = Language.languages()[index];
            return TileWidget.pickItem(
                content: language.name,
                prefix: language.imageIconPath,
                isChosen: language.key == state.languageKey,
                isFirst: index == 0,
                isLast: index == Language.languages().length - 1,
                onTap: () {
                  changeLanguage(context: context, key: language.key);
                });
          }))),
    );
  }

  Future<void> changeLanguage(
      {required BuildContext context, String? key}) async {
    getIt
        .get<BaseLayerCubit>()
        .changeLanguage(context: context, languageKey: key);
  }
}
