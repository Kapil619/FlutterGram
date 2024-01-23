import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:fluttergram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Signup user
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to db
        await _firestore.collection('users').doc(cred.user!.uid).set(
          {
            'email': email,
            'username': username,
            'uid': cred.user!.uid,
            'bio': bio,
            'followers': [],
            'following': [],
            'photoUrl': photoUrl,
          },
        );

        res = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email is invalid';
      } else if (err.code == 'weak-password') {
        res = 'Password should be atleast 6 characters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
