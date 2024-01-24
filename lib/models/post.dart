import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'description': description,
        'postId': postId,
        'uid': uid,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['profImage'],
      datePublished: snapshot['datePublished'],
    );
  }
}
