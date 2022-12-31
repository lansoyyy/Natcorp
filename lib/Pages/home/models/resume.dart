import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:natcorp/Pages/mainButtom/bottom_page.dart';
import 'package:natcorp/Pages/sign%20up/model/user_model.dart';
import 'package:natcorp/services/repositories/add_application_form.dart';
import 'package:natcorp/widgets/text_widget.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  State<ResumeScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<ResumeScreen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final firstName = TextEditingController();

  final pos = TextEditingController();
  final secondName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final address = TextEditingController();
  final num = TextEditingController();

  late String gender = 'Male';
  final List<bool> _isSelected = [true, false];

  final box = GetStorage();

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

    final posDesired = TextFormField(
      autofocus: false,
      controller: pos,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Position Desired cannot be Empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Position Desired");
        }
        return null;
      },
      onSaved: (value) {
        pos.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.work_outline_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Position Desired",
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
    final middle = TextFormField(
      autofocus: false,
      controller: lastName,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Middle Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        lastName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Middle Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //Address field
    final Address = TextFormField(
      autofocus: false,
      controller: address,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Last Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        address.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_on_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Present Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    //PhoneNum field
    final Number = TextFormField(
      autofocus: false,
      controller: num,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{11,}$');
        if (value!.isEmpty) {
          return ("Phone Number is required for Applying");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid Number (11 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        age.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
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

    //Age field
    final Age = TextFormField(
      autofocus: false,
      controller: age,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ("Age is required for Applying");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid Age (Min. 2 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        age.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //sign up button

    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: StreamBuilder<DocumentSnapshot>(
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
            return MaterialButton(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                if (firstName.text == '' ||
                    lastName.text == '' ||
                    secondName.text == '' ||
                    email.text == '' ||
                    address.text == '' ||
                    age.text == '') {
                  Fluttertoast.showToast(
                      msg: 'Cannot Procceed!\nIncomplete Fields!');
                } else {
                  print(box.read('compId'));
                  // signUp(email.text, password.text);

                  addForm(
                      firstName.text,
                      secondName.text,
                      lastName.text,
                      email.text,
                      age.text,
                      address.text,
                      num.text,
                      gender,
                      pos.text,
                      box.read('compId'),
                      box.read('compName'),
                      box.read('compLogo'),
                      data['NSO'],
                      data['NBI'],
                      data['Diploma'],
                      data['COE'],
                      data['SSS'],
                      data['Philhealth'],
                      data['Pag-ibig'],
                      data['TIN'],
                      data['TOR'],
                      data['Brgy Clearance'],
                      data['Police Clearance'],
                      data['Vaccine Card'],
                      data['profile']);

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'status': 'Pending'});

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const bottomButton()));
                  Fluttertoast.showToast(msg: 'Application Added Succesfully!');
                }
              },
              child: const Text(
                "Continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            );
          }),
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
                    const Text(
                      "APPLICATION FORM",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF075009)),
                    ),
                    const SizedBox(height: 30),
                    firstNameField,
                    const SizedBox(height: 15),
                    middle,
                    const SizedBox(height: 15),
                    secondNameField,
                    const SizedBox(height: 15),
                    emailField,
                    const SizedBox(height: 15),
                    Age,
                    const SizedBox(height: 15),
                    Address,
                    const SizedBox(height: 15),
                    Number,
                    const SizedBox(
                      height: 15,
                    ),
                    TextRegular(
                        text: 'Gender', fontSize: 14, color: Colors.grey),
                    const SizedBox(
                      height: 5,
                    ),
                    ToggleButtons(
                        borderRadius: BorderRadius.circular(5),
                        splashColor: Colors.grey,
                        color: Colors.black,
                        selectedColor: Colors.blue,
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int index = 0;
                                index < _isSelected.length;
                                index++) {
                              if (index == newIndex) {
                                _isSelected[index] = true;
                                if (_isSelected[0] == true) {
                                  gender = 'Male';
                                } else {
                                  gender = 'Female';
                                }
                              } else {
                                _isSelected[index] = false;
                              }
                            }
                          });
                        },
                        isSelected: _isSelected,
                        children: const [
                          Icon(Icons.male),
                          Icon(Icons.female),
                        ]),
                    const SizedBox(height: 15),
                    posDesired,
                    const SizedBox(height: 15),
                    const SizedBox(height: 30),
                    signUpButton,
                    const SizedBox(height: 15),
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
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName.text;
    userModel.secondName = secondName.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const bottomButton()),
        (route) => false);
  }
}
