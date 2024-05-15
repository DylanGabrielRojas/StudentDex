import 'package:firebase_storage/firebase_storage.dart';
import 'database.dart';

class StorageService {
  Future<String> getIMGfromID(String name) async {
    String res = '';
    String pathDB = '';
    pathDB = await DatabaseService().getPicturePath(name);
    final storageRef = FirebaseStorage.instance.ref();
    final path = storageRef.child(pathDB);
    res = await path.getDownloadURL();
    return res;
  }  
  
  Future<String> getIMGHighSchool(String pathDB) async {
    String res = '';
    final storageRef = FirebaseStorage.instance.ref();
    final path = storageRef.child(pathDB);
    res = await path.getDownloadURL();
    return res;
  }

}
