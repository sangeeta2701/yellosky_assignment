import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yellosky_assignment/Screens/Auth/login_screen.dart';
import 'package:yellosky_assignment/Screens/main_screen.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  // await dotenv.load();
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget _getInitialScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in
      return MainScreen();
    } else {
      // User is not logged in
      return LoginScreen();
    }}
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: _getInitialScreen(),
            theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: themeColor,
          inputDecorationTheme: InputDecorationTheme(
            // filled: true,
            // fillColor: wColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            hintStyle: blackContentStyl,
             enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: gColor.withOpacity(0.3), width: 1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: gColor.withOpacity(0.3), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: themeColor, width: 1)),
          ),
        ),
          );
           });
  }
}

