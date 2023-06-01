import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/notification/data/notifications/notifications_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/notification/notification_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    getIt.get<NotificationsCubit>().clean();
    getIt.get<NotificationsCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_notification,
          ),
          _buildBody()
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
      if (state is NotificationsSuccess) {
        if (state.notifications.isEmpty) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 80,
            margin:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
            child: Text(
              S.current.txt_no_notification,
              style: BaseTextStyle.body1(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
        return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.notifications.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => NotificationWidget.base(
                    state.notifications[index],
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage(
                                postId:
                                    state.notifications[index].postId!))))));
      }

      return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(bottom: BorderSide(color: BaseColor.grey40))),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ShimmerWidget.base(
                              width: 44, height: 44, shape: BoxShape.circle)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ShimmerWidget.base(
                                    width: double.infinity,
                                    height: 21,
                                    borderRadius: BorderRadius.circular(12))),
                            ShimmerWidget.base(
                                width: 100,
                                height: 16,
                                borderRadius: BorderRadius.circular(12))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }));
    });
  }
}
