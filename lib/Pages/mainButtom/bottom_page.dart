import 'package:flutter/material.dart';
import 'package:natcorp/Pages/Call/call_page.dart';
import 'package:natcorp/Pages/Files/file_page.dart';
import 'package:natcorp/Pages/favorites/favoMain.dart';
import 'package:natcorp/Pages/home/home.dart';
import 'package:natcorp/Pages/profile/profile_page.dart';

class bottomButton extends StatefulWidget {
  const bottomButton({Key? key}) : super(key: key);

  @override
  State<bottomButton> createState() => _bottomButtonState();
}

class _bottomButtonState extends State<bottomButton> {
  int currentTab = 0;
  final List<Widget> screen = [
    HomePage(),
    FilesScreen(),
    CallScreen(),
    FavoriteNew(),
    ProfileScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.call, color: Colors.grey),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CallScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Color(0xFF43B1B7) : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Color(0xFF43B1B7)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = FilesScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cases,
                          color:
                              currentTab == 1 ? Color(0xFF43B1B7) : Colors.grey,
                        ),
                        Text(
                          'Files',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Color(0xFF43B1B7)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = FavoriteNew();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_outline_outlined,
                          color:
                              currentTab == 3 ? Color(0xFF43B1B7) : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Color(0xFF43B1B7)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 4 ? Color(0xFF43B1B7) : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 4
                                  ? Color(0xFF43B1B7)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
