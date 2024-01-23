import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Signup user
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    // required Uint8List file,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //add user to db
        await _firestore.collection('users').doc(cred.user!.uid).set(
          {
            'email': email,
            'username': username,
            'uid': cred.user!.uid,
            'bio': bio,
            'followers': [],
            'following': [],
          },
        );

        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
