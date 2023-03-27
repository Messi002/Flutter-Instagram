import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';

import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

@immutable
class GlobalVariables {
  static const webScreenSize = 600;
  static final homeScreenItem = [
    FeedScreen(),
    SearchScreen(),
   AddPostScreen(),
    Text('4'),
    ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
  ];
}
