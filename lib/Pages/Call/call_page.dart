import 'package:flutter/material.dart';
import 'package:natcorp/widgets/text_widget.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF075009),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ListTile(
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.video_call_outlined,
                        size: 32,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.done_outline_rounded,
                        size: 28,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              title: TextRegular(
                  text: 'Position', fontSize: 14, color: Colors.black),
              subtitle: TextRegular(
                  text: 'Company name - 11/21/2021 - 4:30pm',
                  fontSize: 10,
                  color: Colors.grey),
              tileColor: Colors.white,
              leading: const CircleAvatar(
                minRadius: 25,
                maxRadius: 25,
                backgroundColor: Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }
}
