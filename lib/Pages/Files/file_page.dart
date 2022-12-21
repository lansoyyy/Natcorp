import 'package:flutter/material.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          height: 150,
                          child: Image.asset("assets/logo.png",
                              fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ]),
              ),
            ),
          ),
        ));
  }
}
