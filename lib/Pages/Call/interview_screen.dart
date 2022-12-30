// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';

// class InterviewScreen extends StatefulWidget {
//   const InterviewScreen({Key? key}) : super(key: key);

//   @override
//   State<InterviewScreen> createState() => _InterviewScreenState();
// }

// class _InterviewScreenState extends State<InterviewScreen> {
//   // 1bb40b73746f41d181b09b110635de77
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: "1bb40b73746f41d181b09b110635de77",
//       channelName: "test",
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Agora VideoUIKit'),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(
//                 client: client,
//                 layoutType: Layout.floating,
//                 enableHostControls: true, // Add this to enable host controls
//               ),
//               AgoraVideoButtons(
//                 client: client,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
