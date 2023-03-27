import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/screens/profile_screen.dart';

import '../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  bool isShowUsers = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(labelText: 'Search for a user...'),
          onFieldSubmitted: (String _) {
            log(_);
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isEqualTo: _searchController.text.trim())
                  // .where('username', isGreaterThanOrEqualTo: _searchController.text.trim())
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context) => ProfileScreen(uid: item['uid']),)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item['photoUrl']),
                        ),
                        title: Text(item['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // return MasonryGridView.builder(
                //   gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3),

                //   itemCount: snapshot.data!.docs.length,
                //   itemBuilder: (context, index) {
                //     final item = snapshot.data!.docs[index];
                //     return Image.network(item['postUrl']);
                //   },
                // );

                return MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index];
                    return Image.network(item['photoUrl']);
                  },
                );
              },
            ),
    );
  }
}
