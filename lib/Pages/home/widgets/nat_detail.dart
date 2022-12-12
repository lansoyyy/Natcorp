import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/details.dart';
import 'package:natcorp/Pages/home/models/job.dart';
import 'package:natcorp/widgets/icon_text.dart';

// this is for job details when you click the work from homepage
class natDetail extends StatelessWidget {
  @override
  final Details nats;
  natDetail(this.nats);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
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
            SizedBox(height: 30),
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Image.asset(nats.logoUrl1),
                        ),
                        SizedBox(width: 10),
                        Text(
                          nats.about,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    //save button isMark
                    Row(
                      children: [
                        Icon(
                          nats.isMark
                              ? Icons.bookmark
                              : Icons.bookmark_outline_rounded,
                          color: nats.isMark
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                //Title
                Text(
                  nats.title1,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),
                ...nats.req1
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            //details
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,
                              ),
                              child: Text(
                                e,
                                style: TextStyle(
                                  wordSpacing: 2.5,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
            // icon
          ],
        ),
      ),
    );
  }
}
