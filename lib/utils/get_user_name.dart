import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juno/components/app_theme.dart';

//call to get full name
class GetFullName extends StatelessWidget {
  final String documentId;
  const GetFullName({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();
          String firstName = data?['first name'] ?? 'guest';
          String lastName = data?['last name'] ?? 'guest';
          return Text(
            "$firstName $lastName",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: basicColor,
            ),
          );
        }
        return Text(
          'guest',
          style: TextStyle(
            color: basicColor,
          ),
        );
      },
    );
  }
}

//call to get last name only
class GetLastName extends StatelessWidget {
  final String documentId;
  const GetLastName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();
          String lastName = data?['last name'] ?? 'guest';
          return Text("Last Name: $lastName");
        }
        return const Text('guest');
      },
    );
  }
}

//call to get first name only
class GetFirstName extends StatelessWidget {
  final String documentId;
  const GetFirstName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();
          String firstName = data?['first name'] ?? 'guest';

          return Text("First Name: $firstName");
        }
        return const Text('guest');
      },
    );
  }
}

//call to get date of birth only
class GetDOB extends StatelessWidget {
  final String documentId;
  const GetDOB({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();
          String dOB = data?['age'] ?? 'guest';
          return Text("First Name: $dOB");
        }
        return const Text('guest');
      },
    );
  }
}

//call to get email only
class GetEmail extends StatelessWidget {
  final String documentId;
  const GetEmail({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();

          String email = data?['email'] ?? 'guest';
          return Text("First Name:$email");
        }
        return const Text('guest');
      },
    );
  }
}

//get user photos
class GetPhotot extends StatelessWidget {
  final String documentId;
  const GetPhotot({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data();

          String userPick = data?['User Pick1'] ?? 'guest';
          return Text("First Name:$userPick");
        }
        return const Text('guest');
      },
    );
  }
}
