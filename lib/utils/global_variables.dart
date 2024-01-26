import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/screens/add_post_screen.dart';
import 'package:fluttergram/screens/feed_screen.dart';
import 'package:fluttergram/screens/profile_screen.dart';
import 'package:fluttergram/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: const Text('Coming soon: Likes')),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
