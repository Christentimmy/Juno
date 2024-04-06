import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  //add image to firebase storage
  Future<String> upLoadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child(uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;

  }

  Future<List<String>> upLoadBucchesToStorage(String childName, List<Uint8List> files) async {
  List<String> downloadUrls = [];
  for (int i = 0; i < files.length; i++) {
    String fileName = '$uid-image-$i';
    Reference ref = _storage.ref().child(childName).child(fileName);
    UploadTask uploadTask = ref.putData(files[i]);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    downloadUrls.add(downloadUrl);
  }
  return downloadUrls;
}



}
