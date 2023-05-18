import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/activity/activity_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/path/services_path.dart';

class RecentActivitiesPage extends StatefulWidget {
  const RecentActivitiesPage({Key? key}) : super(key: key);

  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  final _db = FirebaseFirestore.instance;
  List<ActivityModel> acts = List.empty(growable: true);

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
            child: FutureBuilder(
              future: _db
                  .collection(ServicePath.user)
                  .doc(authService.getUserId())
                  .collection(ServicePath.activity)
                  .orderBy("time", descending: true)
                  .get(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  acts.addAll(snapshot.data!.docs.map((e) => ActivityModel.fromJson(e.data())).toList());
                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return ActivityWidget.base(
                          content: "${acts[index].type} ",
                          userName: "${acts[index].nameUserPost} ",
                          imagePath: acts[index].images ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png",
                          time: StringHelper.formatDate(acts[index].time.toDate().toString()),
                        );
                      });
                }
                else{
                  return ShimmerWidget.base(
                      width: 80.0, height: 80.0, shape: BoxShape.circle);
                }
              },
            )
        ),
        // Expanded(
        //   child: SingleChildScrollView(
        //       child: Column(
        //           children: List.generate(
        //     acts.length,
        //     (index) {
        //       return ActivityWidget.base(
        //         content: "${acts[index].type} in ",
        //         userName: "Steemit",
        //         imagePath:
        //             "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png",
        //       );
        //     },
        //   ))),
        // ),
      ],
    ));
  }

// getData() async {
//   var docSnapshot = await _db
//       .collection(ServicePath.user)
//       .doc(authService.getUserId())
//       .collection(ServicePath.activity)
//       .orderBy("time", descending: true)
//       .get();
//   acts.addAll(
//       docSnapshot.docs.map((e) => ActivityModel.fromJson(e.data())).toList());
// }
}
