import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final int _page = 0;
  late final PageController pageController;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children:const [
      
        ],
        // onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: '',
              backgroundColor: _page == 0
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: '',
              backgroundColor: _page == 1
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle),
              label: '',
              backgroundColor: _page == 2
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: '',
              backgroundColor: _page == 3
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: '',
              backgroundColor: _page == 4
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
