import 'package:cloud_firestore/cloud_firestore.dart';

Future addComment(String name, String profilePicture, String userId,
    String comment, String companyId) async {
  final docUser = FirebaseFirestore.instance.collection('Comments').doc();

  final json = {
    'name': name,
    'id': docUser.id,
    'profilePicture': profilePicture,
    'userId': userId,
    'dateTime': DateTime.now(),
    'comment': comment,
    'companyId': companyId,
  };

  await docUser.set(json);
}
