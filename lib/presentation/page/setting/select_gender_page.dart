import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/tile/tile_widget.dart';
import 'package:steemit/util/enum/gender_enum.dart';
import 'package:steemit/util/helper/gender_helper.dart';

class SelectGenderPage extends StatefulWidget {
  final Gender? preGender;

  const SelectGenderPage({Key? key, this.preGender}) : super(key: key);

  @override
  State<SelectGenderPage> createState() => _SelectGenderPageState();
}

class _SelectGenderPageState extends State<SelectGenderPage> {
  Gender? gender;

  @override
  void initState() {
    setState(() {
      gender = widget.preGender;
    });
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
                children: List.generate(Gender.values.length, (index) {
              return TileWidget.pickItem(
                  content: GenderHelper.mapEnumToString(Gender.values[index]),
                  isChosen:
                      gender != null ? gender == Gender.values[index] : false,
                  onTap: () {
                    setState(() {
                      gender = Gender.values[index];
                    });
                  });
            }))),
        BottomSheetWidget.title(
            context: context,
            title: "Select your gender",
            rollbackContent: "Cancel",
            onRollback: () => Navigator.pop(context),
            submitContent: "Done",
            onSubmit: () => Navigator.pop(context, gender)),
      ],
    );
  }
}
