import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
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
    return Column(
      children: [
        Header.background(
            content: S.current.lbl_update_bio,
            prefixContent: S.current.btn_cancel,
            suffixContent: S.current.btn_done,
            onSuffix: () {
              Navigator.pop(context);
            }),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
        child: Column(
          children: [
            TextFieldWidget.common(
                onChanged: (text) {},
                textEditingController: bioController,
                labelText: S.current.lbl_bio,
                hintText: S.current.txt_bio_hint),
          ],
        ));
  }
}
