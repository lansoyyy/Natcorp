import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natcorp/Pages/Call/call_page.dart';
import 'package:natcorp/Pages/Files/file_page.dart';
import 'package:natcorp/Pages/favorites/favoMain.dart';
import 'package:natcorp/Pages/home/widgets/home_app_bar.dart';
import 'package:natcorp/Pages/home/widgets/job_list.dart';
import 'package:natcorp/Pages/home/widgets/nat_corp_details.dart';
import 'package:natcorp/Pages/home/widgets/search_card.dart';
import 'package:natcorp/Pages/home/widgets/work.dart';
import 'package:natcorp/Pages/profile/profile_page.dart';
import 'package:natcorp/utilities/appColors/app_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tagsList = <String>[
    'All',
    '⚡ Production Operator',
    '⭐ Inspector',
    '⚡ Maintenance',
    '⭐ Utility'
  ];

  List<Widget> _buildScreens() {
    return [
      Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(),
                  SearchCard(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: selected == index
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selected == index
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                    )),
                                child: Text(tagsList[index]),
                              ),
                            ),
                        separatorBuilder: (_, index) => const SizedBox(
                              width: 15,
                            ),
                        itemCount: tagsList.length),
                  ),
                  NatCorpDetails(),
                  Work(),
                  JobList(
                    inNotif: false,
                    jobType: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const FilesScreen(),
      const CallScreen(),
      FavoriteNew(),
      const ProfileScreen(),
    ];
  }

  late final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.Kgradient1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.square_fill_on_square_fill),
        title: ("Files"),
        activeColorPrimary: AppColors.Kgradient1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.videocam_circle_fill,
          color: Colors.white,
        ),
        title: ("Appointments"),
        activeColorPrimary: AppColors.Kgradient1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.square_favorites_alt,
        ),
        title: ("Favorites"),
        activeColorPrimary: AppColors.Kgradient1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: AppColors.Kgradient1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
