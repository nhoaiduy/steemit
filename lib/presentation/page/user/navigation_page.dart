import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/user/account_page.dart';
import 'package:steemit/presentation/page/user/home_page.dart';
import 'package:steemit/presentation/page/user/notification_page.dart';
import 'package:steemit/util/style/base_color.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> pages = [
    const HomePage(),
    const AccountPage(),
    const NotificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      initialIndex: 1,
      child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
          ),
          bottomNavigationBar: _bottomTabBar()),
    );
  }

  _bottomTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
          indicatorColor: BaseColor.green500,
          labelColor: BaseColor.green500,
          unselectedLabelColor: BaseColor.grey300,
          tabs: _tabList()),
    );
  }

  _tabList() {
    return const [
      Tab(
        icon: Icon(Icons.home_outlined),
      ),
      Tab(
        icon: Icon(Icons.person_outlined),
      ),
      Tab(
        icon: Icon(Icons.notifications_outlined),
      )
    ];
  }
}
