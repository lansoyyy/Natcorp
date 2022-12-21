import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natcorp/Pages/login/login_page.dart';
import 'package:natcorp/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  final fnameController = TextEditingController();

  final snameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              dynamic data = snapshot.data;
              return Container(
                  child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: ListView(children: [
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: TextBold(
                            text: 'Logout',
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                        'Logout Confirmation',
                                        style: TextStyle(
                                            fontFamily: 'QBold',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to Logout?',
                                        style:
                                            TextStyle(fontFamily: 'QRegular'),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                fontFamily: 'QRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'QRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data['profile']))),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      color: Colors.green),
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        newMethod("First Name", data['firstName'], false,
                            fnameController),
                        newMethod("Last Name", data['secondName'], false,
                            snameController),
                        newMethod("Email Address", data['email'], false,
                            emailController),
                        newMethod(
                            "Password", "********", true, passwordController),
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                            child: MaterialButton(
                              padding: const EdgeInsets.all(15.0),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({
                                    'firstName': fnameController.text == ''
                                        ? data['firstName']
                                        : fnameController.text,
                                    'secondName': snameController.text == ''
                                        ? data['secondName']
                                        : snameController.text,
                                    'email': emailController.text == ''
                                        ? data['email']
                                        : emailController.text,
                                  });

                                  await FirebaseAuth.instance.currentUser!
                                      .updateEmail(emailController.text.trim());

                                  await FirebaseAuth.instance.currentUser!
                                      .updatePassword(
                                          passwordController.text.trim());

                                  await FirebaseAuth.instance.currentUser!
                                      .reauthenticateWithCredential(
                                          EmailAuthProvider.credential(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim()));

                                  emailController.clear();
                                  passwordController.clear();
                                  fnameController.clear();
                                  snameController.clear();
                                  Fluttertoast.showToast(
                                      msg: "Saved Succesfully!");
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                              },
                              child: const Text(
                                "Saved",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ])));
            }));
  }

  Padding newMethod(String labelText, String placeholder,
      bool isPasswordTextField, controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 15, 36, 10),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 6),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
