import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/setting/select_gender_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
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

  XFile? photo;
  File? photoPath;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  final _db = FirebaseFirestore.instance;

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

  Future<void> updateProfile(
      XFile file, String firstName, String lastName, String gender) async {
    try {
      firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child('/${file.name}');
      uploadTask = ref.putFile(File(file.path));

      await uploadTask.whenComplete(() => null);
      String imageUrl = await ref.getDownloadURL();

      await _db.collection('users').doc(uid).update({
        "avatar": imageUrl,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
      });
      getIt.get<MeCubit>().getData();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  pickImage(ImageSource image) async {
    try {
      photo = (await ImagePicker().pickImage(source: image))!;
      if (photo == null) return;
      final tempImage = File(photo!.path);
      setState(() {
        photoPath = tempImage;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future reload() async{
  //   await _db.collection('users').doc(uid).get().then((value) {
  //     if(value.exists)
  //     {
  //       setState(() {
  //         firstNameController.text = value.data()!['firstName'];
  //         lastNameController.text = value.data()!['lastName'];
  //         gender = value.data()!['gender'] ;
  //         if (gender != null) {
  //           genderController.text = GenderHelper.mapEnumToString(gender!);
  //         }
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = widget.userModel;
    return Column(
      children: [
        Header.background(
            content: S.current.btn_update_profile,
            prefixContent: S.current.btn_cancel,
            suffixContent: S.current.btn_update,
            onSuffix: () async {
              unFocus();
              await updateProfile(photo!, firstNameController.text,
                  lastNameController.text, genderController.text);
              if (mounted) Navigator.pop(context);
              //reload();
            }),
        Expanded(
          child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AvatarWidget.base(
                        pickedImagePath: photoPath,
                        imagePath: user.avatar,
                        name: "${user.firstName} ${user.lastName}",
                        size: extraLargeAvatarSize),
                  ),
                  ButtonWidget.text(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      content: user.avatar != null || photo != null
                          ? S.current.btn_change_photo
                          : S.current.btn_add_photo,
                      context: context),
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
                      final result = await BottomSheetWidget.show(
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
        ),
      ],
    );
  }

  void unFocus() => FocusScope.of(context).unfocus();
}
