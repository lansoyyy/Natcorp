import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/models/job.dart';
import 'package:natcorp/Pages/home/widgets/job_detail.dart';
import 'package:natcorp/Pages/home/widgets/job_item.dart';

class JobList extends StatelessWidget {
  final jobList = Job.generateJobs();

  late String jobType;
  late bool? inNotif;

  JobList({required this.jobType, required this.inNotif});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 550,
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => JobDetail(jobList[index]));
                      },
                      child: JobItem(
                        jobList[index],
                        inNotif: inNotif!,
                      )),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: jobList.length);
            }),
      ),
    );
  }
}
