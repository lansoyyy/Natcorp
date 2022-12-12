import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/details.dart';
import 'package:natcorp/Pages/home/widgets/nat.dart';

// this is job item
class NatCorp extends StatelessWidget {
  final Details nats;
  final bool showTime1;
  NatCorp(this.nats, {this.showTime1 = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 500,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  nats.isMark ? Icons.bookmark : Icons.bookmark_outline_rounded,
                  color: nats.isMark
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 15),
        //Title
        Text(
          nats.title1,
        ),
        SizedBox(height: 15),
      ]),
    );
  }
}
