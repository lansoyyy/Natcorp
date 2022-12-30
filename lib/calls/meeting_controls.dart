import 'package:flutter/material.dart';

class MeetingControls extends StatefulWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onLeaveButtonPressed,
  }) : super(key: key);

  @override
  State<MeetingControls> createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool isClickedCam = false;

  bool isClickedCamMic = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                widget.onLeaveButtonPressed();
              },
              icon: Icon(
                Icons.call_end_outlined,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 50,
            width: 50,
            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                widget.onToggleMicButtonPressed();
                setState(() {
                  isClickedCamMic = !isClickedCamMic;
                });
              },
              icon: isClickedCamMic
                  ? Icon(
                      Icons.mic_off_rounded,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.mic,
                      color: Colors.white,
                    ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 50,
            width: 50,
            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                widget.onToggleCameraButtonPressed();
                setState(() {
                  isClickedCam = !isClickedCam;
                });
              },
              icon: isClickedCam
                  ? Icon(
                      Icons.videocam,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.videocam_off_outlined,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
