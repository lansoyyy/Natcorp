import 'package:cloud_firestore/cloud_firestore.dart';

Future addForm(
  String firstName,
  String middleName,
  String lastName,
  String email,
  String age,
  String address,
  String contactNumber,
  String gender,
  String positionDesired,
  String companyId,
  String companyName,
) async {
  final docUser = FirebaseFirestore.instance.collection('Applications').doc();

  final json = {
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'email': email,
    'age': age,
    'address': address,
    'contactNumber': contactNumber,
    'gender': gender,
    'positionDesired': positionDesired,
    'companyId': companyId,
    'companyName': companyName,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
