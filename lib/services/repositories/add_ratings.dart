import 'package:cloud_firestore/cloud_firestore.dart';

Future addRatings(String name, String profilePicture, String userId, int star,
    String companyId) async {
  final docUser = FirebaseFirestore.instance.collection('Ratings').doc();

  final json = {
    'name': name,
    'id': docUser.id,
    'profilePicture': profilePicture,
    'userId': userId,
    'dateTime': DateTime.now(),
    'star': star,
    'companyId': companyId,
  };

  await docUser.set(json);
}
