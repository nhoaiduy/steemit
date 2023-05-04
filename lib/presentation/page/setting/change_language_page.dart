import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/data/model/language.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
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
            return Stack(children: [
              SingleChildScrollView(
                  reverse: true,
                  padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 80,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
                  child: Column(
                      children:
                          List.generate(Language.languages().length, (index) {
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
              BottomSheetWidget.title(
                  context: context,
                  title: S.current.lbl_change_language,
                  submitContent: S.current.btn_done,
                  onSubmit: () {
                    Navigator.pop(context);
                  }),
            ]);
          }
          return const SizedBox.shrink();
        });
  }

  Future<void> changeLanguage(
      {required BuildContext context, String? key}) async {
    getIt
        .get<BaseLayerCubit>()
        .changeLanguage(context: context, languageKey: key);
  }
}
