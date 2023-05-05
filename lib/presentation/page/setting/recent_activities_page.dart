import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/activity/activity_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';

class RecentActivitiesPage extends StatefulWidget {
  const RecentActivitiesPage({Key? key}) : super(key: key);

  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Header.background(
          topPadding: MediaQuery.of(context).padding.top,
          content: S.current.lbl_recent_activities,
          prefixIconPath: Icons.chevron_left,
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
            100,
            (index) {
              return ActivityWidget.base(
                content: "comment in ",
                userName: "Steemit",
                imagePath:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png",
              );
            },
          ))),
        ),
      ],
    ));
  }
}
