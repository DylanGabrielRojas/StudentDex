import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<List<dynamic>> getCharacter() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<dynamic> res = [];
    await db.collection("people").get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        final data = doc.data()! as Map<String,dynamic>;
        res.add({
          'id': doc.id,
          'name':data['name']
        });
      }
    });
    return res;
  }

  Future<List<dynamic>> getHighSchools() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<dynamic> res = [];
    await db.collection("highschool").get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        res.add(doc.id);
      }
    });
    return res;
  }

  Future<String> getPicturePath(String id) async {
    String path = '';
    FirebaseFirestore db = FirebaseFirestore.instance;
    final doc = await db.collection('people').doc(id).get();
    path = doc.data()!['picture'];
    return path;
  }

  Future<Map<String, dynamic>> getCharacterData(String id) async {
    late Map<String, dynamic> data;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('people')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String, dynamic>;
    });
    return data;
  }

  Future<Map<String, dynamic>> getCharacterHighSchool(String id) async {
    late Map<String, dynamic> data;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('highschool')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String, dynamic>;
    });
    return data;
  }

  Future<String> uploadCharacter(dynamic character) async {
    late String id;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('people').add(character).then((documentSnapshot) => {
      id = documentSnapshot.id
    });
    String picturePath = "pictures/$id";
    db.collection('people').doc(id).update({'picture': picturePath});
    return id;
  }
}
