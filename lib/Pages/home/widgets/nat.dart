import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/details.dart';

class Nat extends StatelessWidget {
  final Details details;
  Nat(this.details);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'NatCorp Details',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ])
        ]));
  }
}
