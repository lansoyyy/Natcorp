import 'package:cloud_firestore/cloud_firestore.dart';

Future addFavorites(
    String name,
    String profilePicture,
    String userId,
    String companyId,
    String companyName,
    String companyLogo,
    String desc) async {
  final docUser = FirebaseFirestore.instance.collection('Favorites').doc();

  final json = {
    'name': name,
    'companyName': companyName,
    'companyLogo': companyLogo,
    'desc': desc,
    'id': docUser.id,
    'profilePicture': profilePicture,
    'userId': userId,
    'dateTime': DateTime.now(),
    'companyId': companyId,
  };

  await docUser.set(json);
}
