import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natcorp/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class FilesScreen extends StatefulWidget {
  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  final filesList = [
    'NSO',
    'NBI',
    'Diploma',
    'COE',
    'SSS',
    'Philhealth',
    'Pag-ibig',
    'TIN',
    'TOR',
    'Brgy Clearance',
    'Police Clearance',
    'Vaccine Card',
  ];

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource, String nameOfFile) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Files/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Files/$fileName')
            .getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          nameOfFile: imageURL,
        });

        Fluttertoast.showToast(msg: "File Uploaded Succesfully!");

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: TextBold(text: 'My Files', fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          height: 150,
                          child: Image.asset("assets/logo.png",
                              fit: BoxFit.contain),
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: userData,
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            dynamic data = snapshot.data;

                            print(data);
                            return SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: filesList.length,
                                  itemBuilder: ((context, index) {
                                    print(data[filesList[index]]);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              elevation: 3,
                                              child: SizedBox(
                                                  height: 40,
                                                  width: 200,
                                                  child: Center(
                                                    child: TextRegular(
                                                        text: filesList[index],
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                uploadPicture('gallery',
                                                    filesList[index]);
                                              },
                                              child: const Card(
                                                elevation: 3,
                                                child: SizedBox(
                                                    height: 40,
                                                    width: 50,
                                                    child: Center(
                                                      child: Icon(Icons
                                                          .add_circle_outline_rounded),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            data[filesList[index]] == ''
                                                ? const SizedBox()
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                data[filesList[
                                                                    index]]))),
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                            );
                          }),
                    ]),
              ),
            ),
          ),
        ));
  }
}
