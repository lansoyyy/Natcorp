import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/widgets/home_app_bar.dart';
import 'package:natcorp/Pages/home/widgets/job_list.dart';
import 'package:natcorp/Pages/home/widgets/nat_corp_details.dart';
import 'package:natcorp/Pages/home/widgets/search_card.dart';
import 'package:natcorp/Pages/home/widgets/work.dart';

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

  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  jobType: '',
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).accentColor,
      //   elevation: 0,
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      // bottomNavigationBar: Theme(
      //   data: ThemeData(
      //     splashColor: Colors.transparent,
      //     highlightColor: Colors.transparent,
      //   ),
      //   child: BottomNavigationBar(
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     selectedItemColor: Theme.of(context).primaryColor,
      //     type: BottomNavigationBarType.fixed,
      //     items: [
      //       BottomNavigationBarItem(
      //         label: 'Home',
      //         icon: Icon(
      //           Icons.home,
      //           size: 20,
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Case',
      //         icon: Icon(
      //           Icons.cases_outlined,
      //           size: 20,
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         label: '',
      //         icon: Text(''),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Chat',
      //         icon: Icon(
      //           Icons.bookmark_outline_outlined,
      //           size: 20,
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Person',
      //         icon: Icon(
      //           Icons.person_outline,
      //           size: 20,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
