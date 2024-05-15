import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<List<String>> getCharacter() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<String> res = [];
    await db.collection("people").get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        res.add(doc.id);
      }
    });
    return res;
  }

  Future<String> getPicturePath(String name) async {
    String path = '';
    FirebaseFirestore db = FirebaseFirestore.instance;
    final doc = await db.collection('people').doc(name).get();
    path = doc.data()!['picture'];
    return path;
  }

  Future<Map<String, dynamic>> getCharacterData(String name) async {
    late Map<String, dynamic> data;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('people')
        .doc(name)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String, dynamic>;
    });
    return data;
  }

  Future<Map<String, dynamic>> getCharacterRelations(String name) async {
    late Map<String, dynamic> data;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('relationships')
        .doc(name)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String, dynamic>;
    });
    return data;
  }
}
