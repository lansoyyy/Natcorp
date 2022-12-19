import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/widgets/job_list.dart';
import 'package:natcorp/Pages/search/widgets/search_app_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String query = '';

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
    print('called');
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAppBar(), //back and notif in search page
              Container(
                margin: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (input) {
                          query = input;
                          print(query);
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              'assets/icons/search.png',
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
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
              ), // search and yellow filter
              Expanded(
                  child: JobList(
                inNotif: false,
                jobType: '',
              )),
            ],
          )
        ],
      ),
    );
  }
}
