import 'package:flutter/material.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserModel userModel;

  const UpdateProfilePage({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
                    onTap: () {}, content: "Add photo", context: context),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: "First name",
                    hintText: "Enter first name",
                    required: true),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: "Last name",
                    hintText: "Enter last name",
                    required: true),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: "Email",
                    hintText: "Enter  email",
                    required: true),
              ],
            )),
        BottomSheetWidget.title(
            context: context,
            title: "Update profile",
            prefixContent: "Cancel",
            suffixContent: "Update"),
      ],
    );
  }
}
