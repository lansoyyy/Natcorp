import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natcorp/Pages/sign%20up/model/user_model.dart';
import 'package:natcorp/widgets/agreement_page.dart';
import 'package:natcorp/widgets/verification_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();

  var _value = false;

  //editing Controller
  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final birthdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //first field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstName,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid Name");
        }
        return null;
      },
      onSaved: (value) {
        firstName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //last field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondName,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Last Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        secondName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //last field
    final birthdateField = TextFormField(
      autofocus: false,
      controller: birthdate,
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Birthdate cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        birthdate.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Birthdate",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: password,
      obscureText: true,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //confirm pass field
    final confirmField = TextFormField(
      autofocus: false,
      controller: confirmpassword,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Confirm Password is required for login");
        }
        if (confirmpassword.text != password.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmpassword.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //sign up button

    var isVisible = false;

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          late String fname = '';
          late String sname = '';
          late String bday = '';
          var collection = FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email.text);

          var querySnapshot = await collection.get();

          if (_formKey.currentState!.validate()) {
            if (mounted) {
              setState(() {
                for (var queryDocumentSnapshot in querySnapshot.docs) {
                  Map<String, dynamic> data = queryDocumentSnapshot.data();
                  fname = data['firstName'];
                  sname = data['secondName'];
                  bday = data['birthdate'];
                }
              });
            }

            if (firstName.text == fname &&
                secondName.text == sname &&
                birthdate.text == bday) {
              Fluttertoast.showToast(
                  msg: 'This user already existed or currently banned');
            } else {
              try {
                await _auth
                    .createUserWithEmailAndPassword(
                        email: email.text, password: password.text)
                    .then((_) {
                  postDetailsToFirestore();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => VerifyScreen()));
                });
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            }
          }
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 15),
                    firstNameField,
                    const SizedBox(height: 15),
                    secondNameField,
                    const SizedBox(height: 15),
                    birthdateField,
                    const SizedBox(height: 15),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 15),
                    confirmField,
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        signUp(email.text, password.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AgreementScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: SizedBox(
                          width: 400,
                          child: CheckboxListTile(
                              checkColor: Colors.black,
                              selectedTileColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text(
                                "By signing up on Work@NatCorp \n you agree to our Terms &\n Condition and Privacy Policy",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                              ),
                              value: _value,
                              onChanged: (newValue) {
                                setState(() {
                                  _value = !_value;
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(visible: _value, child: signUpButton),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //signUp controller
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final User user = _auth.currentUser!;

    UserModel userModel = UserModel();

    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName.text;
    userModel.secondName = secondName.text;
    userModel.birthdate = birthdate.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => const bottomButton()),
    //     (route) => false);
  }
}
