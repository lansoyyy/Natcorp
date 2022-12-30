import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:natcorp/Pages/Call/interview_screen.dart';
import 'package:natcorp/calls/join_screen.dart';
import 'package:natcorp/widgets/text_widget.dart';
import 'package:intl/intl.dart';

import '../../services/repositories/configs/api.dart';

class CallScreen extends StatefulWidget {
  CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String meetingId = "";

  bool isMeetingActive = false;

  late final void Function() onJoinMeetingButtonPressed;
  late final void Function(String) onMeetingIdChanged;

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF075009),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Interviews')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('type', isEqualTo: 'Ongoing')
              .orderBy('dateTime')
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
            return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: ((context, index) {
                DateTime created = data.docs[index]['dateTime'].toDate();

                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(created);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ListTile(
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              box.write('meetingId',
                                  data.docs[index]['interviewCode']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VideoSDKQuickStart()));
                            },
                            icon: const Icon(
                              Icons.video_call_outlined,
                              size: 32,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Interviews')
                                  .doc(data.docs[index].id)
                                  .update({'type': 'History'});
                            },
                            icon: const Icon(
                              Icons.done_outline_rounded,
                              size: 28,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: TextRegular(
                        text: data.docs[index]['position'],
                        fontSize: 14,
                        color: Colors.black),
                    subtitle: TextRegular(
                        text:
                            '${data.docs[index]['companyName']} - ${formattedTime}',
                        fontSize: 10,
                        color: Colors.grey),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data.docs[index]['companyLogo']),
                      minRadius: 25,
                      maxRadius: 25,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
