// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hinText;
  final TextInputType textInputType;

  const TextInputField({
    Key? key,
    required this.textEditingController,
     this.isPassword = false,
    required this.hinText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),

      ),
      keyboardType: textInputType,
      obscureText: isPassword,
      enableSuggestions: false,
    );
  }
}
