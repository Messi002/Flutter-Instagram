import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';

@immutable
class GlobalVariables {
  static const webScreenSize = 600;
  static const homeScreenItem = [
    FeedScreen(),
    Text('2'),
   AddPostScreen(),
    Text('4'),
    Text('5'),
  ];
}
