import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:natcorp/Pages/home/models/job.dart';
import 'package:natcorp/Pages/home/models/resume.dart';
import 'package:natcorp/utilities/appColors/app_colors.dart';
import 'package:natcorp/widgets/icon_text.dart';
import 'package:natcorp/widgets/text_widget.dart';

// this is for job details when you click the work from homepage
class JobDetail extends StatelessWidget {
  @override
  final Job job;
  const JobDetail(this.job);

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Image.asset(job.logoUrl),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.company,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextRegular(
                                text: '4.5 ★',
                                fontSize: 12,
                                color: Colors.amber),
                          ],
                        ),
                      ],
                    ),
                    //save button isMark
                    Row(
                      children: [
                        Icon(
                          job.isMark
                              ? Icons.bookmark
                              : Icons.bookmark_outline_rounded,
                          color: job.isMark
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                //Title
                Text(
                  job.title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                //Location and time outlined
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, job.location),
                    IconText(Icons.location_on_outlined, job.time),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Requirements',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...job.req
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                            const SizedBox(width: 10),
                            //details
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 300,
                              ),
                              child: Text(
                                e,
                                style: const TextStyle(
                                  wordSpacing: 1.5,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),

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
                            itemBuilder: ((context, index) {
                              return ListTile(
                                trailing: TextRegular(
                                    text: '12:30pm',
                                    fontSize: 10,
                                    color: Colors.grey),
                                leading: const CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 25,
                                  backgroundColor: Colors.grey,
                                ),
                                title: TextRegular(
                                    text: 'Comment here',
                                    fontSize: 12,
                                    color: Colors.black),
                                subtitle: TextRegular(
                                    text: 'John Doe',
                                    fontSize: 10,
                                    color: Colors.grey),
                              );
                            }),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send,
                                    color: AppColors.Kgradient1,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                //button apply now
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
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
                                      height: 10,
                                    ),
                                    TextBold(
                                        text: 'How was your experience?',
                                        fontSize: 18,
                                        color: Colors.amber),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          // var collection =
                                          //     FirebaseFirestore
                                          //         .instance
                                          //         .collection(
                                          //             'Providers')
                                          //         .where('id',
                                          //             isEqualTo:
                                          //                 data[
                                          //                     'id']);

                                          // var querySnapshot =
                                          //     await collection
                                          //         .get();

                                          // for (var queryDocumentSnapshot
                                          //     in querySnapshot
                                          //         .docs) {
                                          //   Map<String, dynamic>
                                          //       data1 =
                                          //       queryDocumentSnapshot
                                          //           .data();

                                          //   FirebaseFirestore
                                          //       .instance
                                          //       .collection(
                                          //           'Providers')
                                          //       .doc(data['id'])
                                          //       .update({
                                          //     'reviews': FieldValue
                                          //         .arrayUnion([
                                          //       FirebaseAuth
                                          //           .instance
                                          //           .currentUser!
                                          //           .uid
                                          //     ]),
                                          //     'ratings': data1[
                                          //             'ratings'] +
                                          //         rating,
                                          //     'nums':
                                          //         data1['nums'] +
                                          //             1,
                                          //   });
                                          // }

                                          Navigator.pop(context);

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
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResumeScreen()));
                    },
                    child: const Text('Apply Now'),
                  ),
                )
              ],
            )
            // icon
          ],
        ),
      ),
    );
  }
}
