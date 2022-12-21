import 'package:flutter/material.dart';
import 'package:natcorp/widgets/text_widget.dart';

class FilesScreen extends StatelessWidget {
  final filesList = [
    'NSO',
    'NBI',
    'Diploma',
    'COE',
    'SSS',
    'Philhealth',
    'Pag-ibig',
    'TIN',
    'TOR',
    'Brgy. Clearance',
    'Police Clearance',
    'Vaccine Card'
  ];

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: 150,
                        child:
                            Image.asset("assets/logo.png", fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: filesList.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 3,
                                      child: SizedBox(
                                          height: 40,
                                          width: 200,
                                          child: Center(
                                            child: TextRegular(
                                                text: filesList[index],
                                                fontSize: 18,
                                                color: Colors.black),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(filesList[index]);
                                      },
                                      child: const Card(
                                        elevation: 3,
                                        child: SizedBox(
                                            height: 40,
                                            width: 50,
                                            child: Center(
                                              child: Icon(Icons
                                                  .add_circle_outline_rounded),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
