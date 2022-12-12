import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/details.dart';
import 'package:natcorp/Pages/home/widgets/nat_corp.dart';
import 'package:natcorp/Pages/home/widgets/nat_detail.dart';

import 'job_item.dart';

// this is like job_list
class NatCorpDetails extends StatelessWidget {
  final natcorpDetails = Details.generatedetails();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 150,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => natDetail(natcorpDetails[index]));
              },
              child: NatCorp(natcorpDetails[index])),
          separatorBuilder: (_, index) => SizedBox(width: 15),
          itemCount: natcorpDetails.length),
      // child: ListView.separated(
      //     padding: EdgeInsets.symmetric(horizontal: 25),
      //     scrollDirection: Axis.horizontal,
      //   itemBuilder: (context, index) => NatCorp(natcorpDetails[index]),

      //     separatorBuilder: (_, index) => SizedBox(width: 15),
      //     itemCount: natcorpDetails.length));
    );
  }
}
