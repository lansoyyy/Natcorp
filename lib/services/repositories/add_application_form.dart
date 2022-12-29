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
    String companyLogo,
    String nso,
    String nbi,
    String diploma,
    String coe,
    String sss,
    String philhealth,
    String pagibig,
    String tin,
    String tor,
    String brgyclearance,
    String policeClearance,
    String vaccineCard) async {
  final docUser = FirebaseFirestore.instance.collection('Applications').doc();

  final json = {
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'email': email,
    'age': age,
    'address': address,
    'contactNumber': contactNumber,
    'companyLogo': companyLogo,
    'gender': gender,
    'positionDesired': positionDesired,
    'companyId': companyId,
    'companyName': companyName,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'NSO': nso,
    'NBI': nbi,
    'Diploma': diploma,
    'COE': coe,
    'SSS': sss,
    'Philhealth': philhealth,
    'Pag-ibig': pagibig,
    'TIN': tin,
    'TOR': tor,
    'Brgy Clearance': brgyclearance,
    'Police Clearance': policeClearance,
    'Vaccine Card': vaccineCard,
    'status': 'Pending'
  };

  await docUser.set(json);
}
