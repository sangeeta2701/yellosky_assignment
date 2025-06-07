import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yellosky_assignment/Screens/Auth/login_screen.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
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

