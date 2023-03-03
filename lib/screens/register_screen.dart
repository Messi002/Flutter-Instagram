import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_input.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final bioController = useTextEditingController();
    final usernameController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: AppColors.primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            // Avatar....
            Stack(
              children: [
               const CircleAvatar(
                  radius: 64,

                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.add_a_photo),),),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextInputField(
                textEditingController: usernameController,
                hinText: 'Enter your user',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
             TextInputField(
                textEditingController: bioController,
                hinText: 'Enter your bio',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
             TextInputField(
                textEditingController: emailController,
                hinText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextInputField(
              textEditingController: passwordController,
              hinText: 'Enter your password',
              textInputType: TextInputType.text,
              isPassword: true,
            ),
            const SizedBox(
              height: 64,
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                color: AppColors.blueColor,
                  
                  shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.all(Radius.circular(4))
                )),
                child: const Text('Register'),
              ),
            ),
            const SizedBox(height: 12,),
              Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text('Already an account?'),
                ),  GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Login up', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
