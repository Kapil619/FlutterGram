import 'package:flutter/material.dart';
import 'package:fluttergram/screens/add_post_screen.dart';
import 'package:fluttergram/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Likes'),
  Text('Profile'),
];
