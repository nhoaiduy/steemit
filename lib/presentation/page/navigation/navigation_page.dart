import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/page/navigation/account_page.dart';
import 'package:steemit/presentation/page/navigation/home_page.dart';
import 'package:steemit/presentation/page/navigation/notification_page.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
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

  Widget _bottomTabBar() {
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

  Widget accountShimmer() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_account,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.7, color: BaseColor.grey40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: ShimmerWidget.base(
                                  width: 80.0,
                                  height: 80.0,
                                  shape: BoxShape.circle)),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ShimmerWidget.base(
                                          width: 70,
                                          height: 20,
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  ShimmerWidget.base(
                                      width: 50,
                                      height: 18,
                                      borderRadius: BorderRadius.circular(12.0))
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ShimmerWidget.base(
                                          width: 70,
                                          height: 20,
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  ShimmerWidget.base(
                                      width: 50,
                                      height: 18,
                                      borderRadius: BorderRadius.circular(12.0))
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ShimmerWidget.base(
                                          width: 70,
                                          height: 20,
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  ShimmerWidget.base(
                                      width: 50,
                                      height: 18,
                                      borderRadius: BorderRadius.circular(12.0))
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ShimmerWidget.base(
                              width: 120,
                              height: 24,
                              borderRadius: BorderRadius.circular(12.0))),
                      GestureDetector(
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 16.0),
                            color: Colors.transparent,
                            child: ShimmerWidget.base(
                                width: 50,
                                height: 20,
                                borderRadius: BorderRadius.circular(8.0))),
                      ),
                      ShimmerWidget.base(
                          width: screenWidth - 32,
                          height: 48,
                          borderRadius: BorderRadius.circular(12.0))
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return const PostShimmer();
                    })
              ],
            ),
          ))
        ],
      ),
    );
  }
}
