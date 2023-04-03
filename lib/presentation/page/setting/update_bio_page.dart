import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class UpdateBioPage extends StatefulWidget {
  final String? bio;

  const UpdateBioPage({Key? key, this.bio}) : super(key: key);

  @override
  State<UpdateBioPage> createState() => _UpdateBioPageState();
}

class _UpdateBioPageState extends State<UpdateBioPage> {
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    if (widget.bio != null) {
      setState(() {
        bioController.text = widget.bio!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 72.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),

            child: Column(
              children: [
                TextFieldWidget.common(
                    onChanged: (text) {},
                    textEditingController: bioController,
                    labelText: S.current.lbl_bio,
                    hintText: S.current.txt_bio_hint),
              ],
            )),
        BottomSheetWidget.title(
            context: context,
            title: S.current.lbl_update_bio,
            rollbackContent: S.current.btn_cancel,
            submitContent: S.current.btn_update),

      ],
    );
  }
}
