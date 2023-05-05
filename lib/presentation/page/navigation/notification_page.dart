import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/notification/notification_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_notification,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    List.generate(100, (index) => NotificationWidget.base()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
