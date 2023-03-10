import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  late final TextEditingController _description;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  void postImage(
    String uid,
    String username,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _description.text.trim(), uid, _file!, username, profileImage);

      if (res == 'Succesful Upload.') {
        setState(() {
          _isLoading = true;
        });
        showSnackBarMsg(context, 'Posted!');
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBarMsg(context, res);
        clearImage();
      }
    } catch (e) {
      log(e.toString());
      clearImage();
    }
  }

  void _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: [
            const Divider(
              color: AppColors.primaryColor,
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            const Divider(
              color: AppColors.primaryColor,
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            const Divider(
              color: AppColors.primaryColor,
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    UserModel userProd = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectImage(context),
                icon: const Icon(
                  Icons.upload,
                  size: 35,
                )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Post to'),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () => postImage(userProd.uid, userProd.username, userProd.photoUrl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CircleAvatar(
                      // user.photoUrl
                      backgroundImage: NetworkImage(userProd.photoUrl),
                      // backgroundImage: NetworkImage(
                      //   'https://images.unsplash.com/photo-1677761215878-1030a5840dd3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      // ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: _description,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          )),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}


// 3: 18 : 19