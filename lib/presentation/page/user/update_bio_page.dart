import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class UpdateBioPage extends StatefulWidget {
  final String? bio;

  const UpdateBioPage({Key? key, this.bio}) : super(key: key);

  @override
  State<UpdateBioPage> createState() => _UpdateBioPageState();
}

class _UpdateBioPageState extends State<UpdateBioPage> {
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
                    labelText: "Bio",
                    hintText: "Enter your bio"),
              ],
            )),
        BottomSheetWidget.title(
            context: context,
            title: "Update bio",
            prefixContent: "Cancel",
            suffixContent: "Update"),
      ],
    );
  }
}
