import 'package:badges/badges.dart' as b;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natcorp/Pages/Call/call_page.dart';
import 'package:natcorp/Pages/Files/file_page.dart';
import 'package:natcorp/Pages/favorites/favoMain.dart';
import 'package:natcorp/Pages/home/home.dart';
import 'package:natcorp/Pages/profile/profile_page.dart';
import 'package:natcorp/widgets/text_widget.dart';

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
    const ProfileScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: b.Badge(
        badgeContent: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Interviews')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('type', isEqualTo: 'Ongoing')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('error');
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('waiting');
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              }

              final data = snapshot.requireData;
              return TextRegular(
                  text: snapshot.data!.size.toString(),
                  fontSize: 12,
                  color: Colors.white);
            }),
        child: FloatingActionButton(
          child: const Icon(Icons.call, color: Colors.grey),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CallScreen()));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
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
                          color: currentTab == 0
                              ? const Color(0xFF43B1B7)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? const Color(0xFF43B1B7)
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
                          color: currentTab == 1
                              ? const Color(0xFF43B1B7)
                              : Colors.grey,
                        ),
                        Text(
                          'Files',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? const Color(0xFF43B1B7)
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
                          color: currentTab == 3
                              ? const Color(0xFF43B1B7)
                              : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? const Color(0xFF43B1B7)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 4
                              ? const Color(0xFF43B1B7)
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 4
                                  ? const Color(0xFF43B1B7)
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
