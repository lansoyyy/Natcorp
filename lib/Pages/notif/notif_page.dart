import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:natcorp/Pages/home/widgets/job_list.dart';
import 'package:natcorp/widgets/icon_text.dart';
import 'package:natcorp/widgets/text_widget.dart';
import 'package:intl/intl.dart';
import '../../utilities/appColors/app_colors.dart';
import '../home/models/job.dart';
import '../home/models/resume.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  late String name = '';
  late String profilePicture = '';
  late String myStatus = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          name = data['firstName'] + ' ' + data['secondName'];

          profilePicture = data['profile'];
          myStatus = data['status'];
        }
      });
    }
  }

  final box = GetStorage();

  final jobList = Job.generateJobs();

  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:
            TextBold(text: 'Notifications', fontSize: 24, color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 550,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Company').snapshots(),
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
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  List comments = data.docs[index]['comments'];

                  List fav = data.docs[index]['fav'];

                  List rates = data.docs[index]['rates'];

                  double num =
                      data.docs[index]['ratings'] / data.docs[index]['reviews'];
                  return Banner(
                    message: 'New',
                    location: BannerLocation.topStart,
                    child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(25),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      )),
                                  height: 550,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 60,
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Image.network(
                                                          data.docs[index]
                                                              ['companyLogo']),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.docs[index]
                                                              ['companyName'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextRegular(
                                                            text:
                                                                '${num.toStringAsFixed(2)} ★',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.amber),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                fav.contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid) ==
                                                        false
                                                    ? GestureDetector(
                                                        onTap: (() {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Company')
                                                              .doc(data
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            'fav': FieldValue
                                                                .arrayUnion([
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                            ]),
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                        child: Icon(
                                                          fav.contains(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              ? Icons.bookmark
                                                              : Icons
                                                                  .bookmark_outline_outlined,
                                                          color: fav.contains(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Colors.black,
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: (() {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Company')
                                                              .doc(data
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            'fav': FieldValue
                                                                .arrayRemove([
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                            ]),
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                        child: Icon(
                                                          fav.contains(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              ? Icons.bookmark
                                                              : Icons
                                                                  .bookmark_outline_outlined,
                                                          color: fav.contains(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Colors.black,
                                                        ),
                                                      )
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            //Title
                                            Text(
                                              data.docs[index]['position'],
                                              style: const TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 15),
                                            //Location and time outlined
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconText(
                                                    Icons.location_on_outlined,
                                                    data.docs[index]
                                                        ['companyAddress']),
                                                IconText(
                                                    Icons.location_on_outlined,
                                                    'Full Time'),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            const Text(
                                              'Requirements',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  //details
                                                  ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxWidth: 300,
                                                    ),
                                                    child: Text(
                                                      data.docs[index]
                                                          ['positionDetails'],
                                                      style: const TextStyle(
                                                        wordSpacing: 1.5,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ExpansionTile(
                                              title: TextRegular(
                                                text: 'View Comments',
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            comments.length,
                                                        itemBuilder:
                                                            ((context, index1) {
                                                          return ListTile(
                                                            trailing: TextRegular(
                                                                text: data.docs[index]
                                                                            [
                                                                            'comments']
                                                                        [index1]
                                                                    ['time'],
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .grey),
                                                            leading:
                                                                CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  data.docs[index]
                                                                              ['comments']
                                                                          [
                                                                          index1]
                                                                      [
                                                                      'profile']),
                                                              minRadius: 25,
                                                              maxRadius: 25,
                                                              backgroundColor:
                                                                  Colors.grey,
                                                            ),
                                                            title: TextRegular(
                                                                text: data.docs[index]
                                                                            [
                                                                            'comments']
                                                                        [index1]
                                                                    ['comment'],
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                            subtitle: TextRegular(
                                                                text: data.docs[index]
                                                                            [
                                                                            'comments']
                                                                        [index1]
                                                                    ['name'],
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .grey),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: TextFormField(
                                                          controller:
                                                              commentController,
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed: () {
                                                                String tdata = DateFormat(
                                                                        "hh:mm a")
                                                                    .format(DateTime
                                                                        .now());
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Company')
                                                                    .doc(data
                                                                        .docs[
                                                                            index]
                                                                        .id)
                                                                    .update({
                                                                  'comments':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    {
                                                                      'name':
                                                                          name,
                                                                      'profile':
                                                                          profilePicture,
                                                                      'time':
                                                                          tdata,
                                                                      'comment':
                                                                          commentController
                                                                              .text,
                                                                    },
                                                                  ]),
                                                                });
                                                                commentController
                                                                    .clear();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: const Icon(
                                                                Icons.send,
                                                                color: AppColors
                                                                    .Kgradient1,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //button apply now
                                            rates.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? const SizedBox()
                                                : Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 25,
                                                      right: 25,
                                                    ),
                                                    height: 45,
                                                    width: double.maxFinite,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 0,
                                                              primary:
                                                                  Colors.amber,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              )),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                child: SizedBox(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      TextBold(
                                                                          text:
                                                                              'How was your experience?',
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.amber),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Center(
                                                                        child: RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              5,
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              const EdgeInsets.symmetric(horizontal: 0.0),
                                                                          itemBuilder: (context, _) =>
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) async {
                                                                            var collection =
                                                                                FirebaseFirestore.instance.collection('Company').where('id', isEqualTo: data.docs[index].id);

                                                                            var querySnapshot =
                                                                                await collection.get();

                                                                            for (var queryDocumentSnapshot
                                                                                in querySnapshot.docs) {
                                                                              Map<String, dynamic> data1 = queryDocumentSnapshot.data();

                                                                              FirebaseFirestore.instance.collection('Company').doc(data.docs[index].id).update({
                                                                                'rates': FieldValue.arrayUnion([
                                                                                  FirebaseAuth.instance.currentUser!.uid
                                                                                ]),
                                                                                'ratings': data1['ratings'] + rating,
                                                                                'reviews': data1['reviews'] + 1,
                                                                              });
                                                                            }

                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            Fluttertoast.showToast(msg: 'Rated Succesfully!');

                                                                            // print(rating);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: const Text('Rate'),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 25,
                                                right: 25,
                                              ),
                                              height: 45,
                                              width: double.maxFinite,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    )),
                                                onPressed: () {
                                                  if (myStatus == 'Pending') {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'You can only submit one application at a time');
                                                  } else {
                                                    box.write(
                                                        'compName',
                                                        data.docs[index]
                                                            ['companyName']);

                                                    box.write('compId',
                                                        data.docs[index].id);

                                                    box.write(
                                                        'compLogo',
                                                        data.docs[index]
                                                            ['companyLogo']);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ResumeScreen()));
                                                  }
                                                },
                                                child: const Text('Apply Now'),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 200,
                                        ),
                                        // icon
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: Image.network(
                                            data.docs[index]['companyLogo']),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[index]['companyName'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextRegular(
                                              text:
                                                  '${num.toStringAsFixed(2)} ★',
                                              fontSize: 12,
                                              color: Colors.amber),
                                        ],
                                      ),
                                    ],
                                  ),
                                  fav.contains(FirebaseAuth
                                              .instance.currentUser!.uid) ==
                                          false
                                      ? GestureDetector(
                                          onTap: (() {
                                            FirebaseFirestore.instance
                                                .collection('Company')
                                                .doc(data.docs[index].id)
                                                .update({
                                              'fav': FieldValue.arrayUnion([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ]),
                                            });
                                          }),
                                          child: Icon(
                                            fav.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? Icons.bookmark
                                                : Icons
                                                    .bookmark_outline_outlined,
                                            color: fav.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? Theme.of(context).primaryColor
                                                : Colors.black,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: (() {
                                            FirebaseFirestore.instance
                                                .collection('Company')
                                                .doc(data.docs[index].id)
                                                .update({
                                              'fav': FieldValue.arrayRemove([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ]),
                                            });
                                          }),
                                          child: Icon(
                                            fav.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? Icons.bookmark
                                                : Icons
                                                    .bookmark_outline_outlined,
                                            color: fav.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? Theme.of(context).primaryColor
                                                : Colors.black,
                                          ),
                                        )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                data.docs[index]['position'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconText(Icons.location_on_outlined,
                                      data.docs[index]['companyAddress']),
                                  // if (showTime)
                                  IconText(
                                      Icons.access_time_outlined, 'Full Time'),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: snapshot.data?.size ?? 0,
              );
            }),
      ),
    );
  }
}
