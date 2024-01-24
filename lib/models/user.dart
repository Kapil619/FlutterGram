import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'uid': uid,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
