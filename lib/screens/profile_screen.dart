import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/FollowButton.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({required this.uid, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['username']),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(postLen, 'posts'),
                              buildStatColumn(20, 'followers'),
                              buildStatColumn(20, 'following'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FollowButton(
                                text: 'Edit Profile',
                                textColor: primaryColor,
                                backgroundColor: mobileBackgroundColor,
                                borderColor: Colors.grey,
                                function: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    userData['bio'],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
