import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import 'package:juno/utils/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user and user details to firebase
  Future<void> createUser({
    required String email,
    required String password,
    required String doB,
    required String firstName,
    required String lastName,
    required String occuPy,
    required Uint8List file,
  }) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String photoUrl =
        await StorageMethods().upLoadImageToStorage('ProfilePics', file);
    //add users

    await _firestore.collection('users').doc(cred.user!.uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'password': password,
      'age': doB,
      'photoUrl': photoUrl,
      'Occupation': occuPy,
      'uid':cred.user!.uid,
    });
  }
}
