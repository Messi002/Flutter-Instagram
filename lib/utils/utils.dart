import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  ImagePicker _imagePicker = ImagePicker();

  XFile? file = await _imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  log('no image selected');
}

showSnackBarMsg(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
