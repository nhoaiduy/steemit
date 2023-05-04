import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/user/controller/user_controller_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/snackbar/snackbar_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class UpdateBioPage extends StatefulWidget {
  final String? bio;

  const UpdateBioPage({Key? key, this.bio}) : super(key: key);

  @override
  State<UpdateBioPage> createState() => _UpdateBioPageState();
}

class _UpdateBioPageState extends State<UpdateBioPage> {
  final TextEditingController bioController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    if (widget.bio != null) {
      setState(() {
        bioController.text = widget.bio!;
      });
    }

    getIt.get<UserControllerCubit>().stream.listen((event) async {
      if (!mounted) return;
      if (event is UserControllerFailure) {
        setState(() {
          _errorText = event.message;
        });
        return;
      }
      if (event is UserControllerSuccess) {
        SnackBarWidget.show(
            context: context,
            snackBar: SnackBarWidget.success(
                content: S.current.txt_update_successfully));
        await getIt.get<MeCubit>().getData();
        if (mounted) Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header.background(
            content: S.current.lbl_update_bio,
            prefixContent: S.current.btn_cancel,
            suffixContent: S.current.btn_done,
            onSuffix: () => updateBio()),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget.common(
                  onChanged: (text) {},
                  textEditingController: bioController,
                  labelText: S.current.lbl_bio,
                  hintText: S.current.txt_bio_hint),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    _errorText!,
                    style: BaseTextStyle.body1(color: BaseColor.red500),
                  ),
                )
            ],
          )),
    );
  }

  void updateBio() {
    clearError();
    unFocus();
    getIt.get<UserControllerCubit>().updateBio(bio: bioController.text);
  }

  void clearError() => setState(() {
        _errorText = null;
      });

  void unFocus() => FocusScope.of(context).unfocus();
}
