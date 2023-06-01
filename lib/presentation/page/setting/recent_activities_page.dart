import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/activity/data/activities/activities_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/widget/activity/activity_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class RecentActivitiesPage extends StatefulWidget {
  const RecentActivitiesPage({Key? key}) : super(key: key);

  @override
  State<RecentActivitiesPage> createState() => _RecentActivitiesPageState();
}

class _RecentActivitiesPageState extends State<RecentActivitiesPage> {
  @override
  void initState() {
    getIt.get<ActivitiesCubit>().clean();
    getIt.get<ActivitiesCubit>().getData();
    super.initState();
  }

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
        _buildBody()
      ],
    ));
  }

  Widget _buildBody() {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        if (state is ActivitiesSuccess) {
          if (state.activities.isEmpty) {
            return Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 80,
              margin:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Text(
                S.current.txt_no_activity,
                style: BaseTextStyle.body1(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.activities.length,
                itemBuilder: (context, index) => ActivityWidget.base(
                    activityModel: state.activities[index],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage(
                                postId: state.activities[index].postId!))))),
          );
        }
        return Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: BaseColor.grey40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.base(
                            width: double.infinity,
                            height: 21,
                            borderRadius: BorderRadius.circular(8.0)),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: ShimmerWidget.base(
                              width: 72,
                              height: 16,
                              borderRadius: BorderRadius.circular(8.0)),
                        )
                      ],
                    ),
                  );
                }));
      },
    );
  }
}
