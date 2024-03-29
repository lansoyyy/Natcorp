import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/job.dart';
import 'package:natcorp/widgets/icon_text.dart';

import '../../../widgets/text_widget.dart';

class JobItem extends StatelessWidget {
  final Job job;
  final bool showTime;
  final bool inNotif;
  const JobItem(this.job, {this.showTime = false, this.inNotif = false});
  @override
  Widget build(BuildContext context) {
    return inNotif
        ? Banner(
            location: BannerLocation.topStart,
            message: 'New',
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            job.company,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Icon(
                        job.isMark
                            ? Icons.bookmark
                            : Icons.bookmark_outline_outlined,
                        color: job.isMark
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    job.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(Icons.location_on_outlined, job.location),
                      if (showTime)
                        IconText(Icons.access_time_outlined, job.time),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
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
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.company,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
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
                    Icon(
                      job.isMark
                          ? Icons.bookmark
                          : Icons.bookmark_outline_outlined,
                      color: job.isMark
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  job.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, job.location),
                    if (showTime)
                      IconText(Icons.access_time_outlined, job.time),
                  ],
                ),
              ],
            ),
          );
  }
}
