import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Instagram clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.mobileBackgroundColor,
          ),
          // home: const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout()),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.primaryColor),
                );
              }

              return const LoginScreen();
            },
          )),
    );
  }
}




//flutter run -d chrome --web-renderer html



 // onTap: () {
                  //   log('pressed');
                  //   Navigator.of(context).push(
                  //     PageRouteBuilder(
                  //       opaque: false,
                  //       pageBuilder: (BuildContext context, _, __) {
                  //         return ProductCategorySeeAll();
                  //       },
                  //       transitionsBuilder: (_, Animation<double> animation,
                  //           __, Widget child) {
                  //         return FadeTransition(
                  //           opacity: Tween<double>(begin: 0.0, end: 1.0)
                  //               .animate(animation),
                  //           child: child,
                  //         );
                  //       },
                  //       transitionDuration: const Duration(milliseconds: 800),
                  //     ),
                  //   );
                  // },