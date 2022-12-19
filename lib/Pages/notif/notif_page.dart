import 'package:flutter/material.dart';
import 'package:natcorp/Pages/home/widgets/job_list.dart';
import 'package:natcorp/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        title: TextRegular(
            text: 'Notifications', fontSize: 18, color: Colors.black),
        centerTitle: true,
      ),
      body: JobList(jobType: '', inNotif: true),
    );
  }
}
