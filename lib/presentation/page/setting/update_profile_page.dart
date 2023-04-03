import 'package:flutter/material.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/page/setting/select_gender_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/enum/gender_enum.dart';
import 'package:steemit/util/helper/gender_helper.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserModel userModel;

  const UpdateProfilePage({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  Gender? gender;

  @override
  void initState() {
    setState(() {
      firstNameController.text = widget.userModel.firstName;
      lastNameController.text = widget.userModel.lastName;
      emailController.text = widget.userModel.email;
      gender = widget.userModel.gender;
      if (gender != null) {
        genderController.text = GenderHelper.mapEnumToString(gender!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userModel;
    return Stack(
      children: [
        SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 80.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: AvatarWidget.base(
                      imagePath: user.avatar,
                      name: "${user.firstName} ${user.lastName}",
                      size: extraLargeAvatarSize),
                ),
                ButtonWidget.text(
                    onTap: () {}, content: user.avatar!=null ? S.current.btn_change_photo:S.current.btn_add_photo, context: context),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_first_name,
                    hintText: S.current.txt_first_name_hint,
                    prefixIconPath: Icons.text_fields_outlined,
                    textEditingController: firstNameController,
                    required: true),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_last_name,
                    hintText: S.current.txt_last_name_hint,
                    prefixIconPath: Icons.text_fields_outlined,
                    textEditingController: lastNameController,
                    required: true),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () async {
                    final result = await BottomSheetWidget.base(
                        context: context,
                        body: SelectGenderPage(
                          preGender: gender,
                        ));
                    if (result != null) {
                      setState(() {
                        gender = result;
                        genderController.text =
                            GenderHelper.mapEnumToString(result);
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      TextFieldWidget.common(
                          onChanged: (text) {},
                          labelText: S.current.lbl_gender,
                          textEditingController: genderController,
                          prefixIconPath: Icons.people_outline,
                          readOnly: true,
                          hintText: S.current.txt_gender_hint),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 80.0,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_email,
                    hintText: S.current.txt_email_hint,
                    prefixIconPath: Icons.email_outlined,
                    textEditingController: emailController,
                    enable: false,
                    required: true),
              ],
            )),
        BottomSheetWidget.title(
            context: context,
            title: S.current.btn_update_profile,
            rollbackContent: S.current.btn_cancel,
            submitContent: S.current.btn_update),
      ],
    );
  }
}
