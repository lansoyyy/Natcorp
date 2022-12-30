import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:natcorp/calls/meeting_screen.dart';
import 'package:natcorp/utilities/appColors/app_colors.dart';
import 'package:natcorp/widgets/text_widget.dart';

import '../services/repositories/configs/api.dart';

class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key}) : super(key: key);

  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            TextRegular(text: 'Interview', fontSize: 18, color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.Kgradient1,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
                meetingId: meetingId,
                token: token,
                leaveMeeting: () {
                  setState(() => isMeetingActive = false);
                },
              )
            : JoinScreen(
                onMeetingIdChanged: (value) => meetingId = value,
                onCreateMeetingButtonPressed: () async {
                  meetingId = await createMeeting();
                  setState(() => isMeetingActive = true);
                },
                onJoinMeetingButtonPressed: () {
                  setState(() => isMeetingActive = true);
                },
              ),
      ),
    );
  }
}

class JoinScreen extends StatelessWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;

  JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
  }) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          TextBold(
              text: 'Meeting ID: ${box.read('meetingId')}',
              fontSize: 18,
              color: Colors.grey),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                decoration: const InputDecoration(
                  hintText: "Meeting ID",
                  border: OutlineInputBorder(),
                ),
                onChanged: onMeetingIdChanged),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            color: AppColors.Kgradient1,
            height: 50,
            minWidth: 200,
            child: TextBold(text: 'Join', fontSize: 18, color: Colors.white),
            onPressed: onJoinMeetingButtonPressed,
          )
        ],
      ),
    );
  }
}
