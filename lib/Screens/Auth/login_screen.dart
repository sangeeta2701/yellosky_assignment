import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Screens/Auth/signup_screen.dart';
import 'package:yellosky_assignment/Screens/main_screen.dart';
import 'package:yellosky_assignment/Widget/customThemeButton.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';
   bool _isObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // void _loginMethod() async {
  //   setState(() {
  //     _errorMessage = '';
  //   });

  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     Fluttertoast.showToast(msg: "Login Successful!!");
  //     // ignore: use_build_context_synchronously
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   // MaterialPageRoute(builder: (context) => HomeScreen()),
  //     // );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found' || e.code == 'wrong-password') {
  //       setState(() {
  //         _errorMessage = 'Invalid Credentials';
  //         Fluttertoast.showToast(msg: _errorMessage);
  //       });
  //     } else {
  //       setState(() {
  //         _errorMessage = 'An error occurred. Please try again.';
  //         Fluttertoast.showToast(msg: _errorMessage);
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _errorMessage = 'An error occurred. Please try again.';
  //       Fluttertoast.showToast(msg: _errorMessage);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height40,
                Text(
                  "Login",
                  style:  GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: themeColor,
                        )
                ),
                height12,
                 Text(
                  "Good to see you again!",
                  style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor)
                ),
                height40,
                TextFormField(
                  controller: emailController,
                  style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email",
                  hintStyle:GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter email";
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return "Enter Correct email";
                    } else {
                      return null;
                    }
                  },
                ),
                height20,
                TextFormField(
                  
                  controller: passwordController,
                  style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                  obscureText: _isObscured,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(hintText: "Password", hintStyle: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
     suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: bColor.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 5) {
                      return "Password can't be less than 5 characters";
                    }
                    if (value.length > 15) {
                      return "Password can't be more  than 15 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                 height20,
                        Align(alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){}, child: Text("Forget Password", style: GoogleFonts.poppins(
    fontSize: 13.sp, fontWeight: FontWeight.w600, color: themeColor))),),
                height40,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customThemeButton("Login", () {
                          if (_formKey.currentState!.validate()) {
                            // _loginMethod();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                          }
                        }),
                       
                          height20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignupScreen()));
                                },
                                child: Text(
                                  "Signup",
                                  style:     GoogleFonts.poppins(
    fontSize: 13.sp, fontWeight: FontWeight.w600, color: themeColor),
                                ))
                          ],
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}