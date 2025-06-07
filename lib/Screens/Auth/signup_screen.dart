import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Screens/Auth/login_screen.dart';
import 'package:yellosky_assignment/Widget/customThemeButton.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();

  bool _isObscured = true;
  bool _isObscured1 = true;

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
                    "Signup",
                    style:GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: themeColor,
                        )
                       
                  ),
                  height12,
                  Text(
                    "Create account to get started...",
                    style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                  ),
                  height40,
                  TextFormField(
                    controller: nameController,
                    style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter name";
                      } if (value.length < 5) {
                        return "Name can't be less than 3 characters";
                      }
                      if (value.length > 15) {
                        return "Name can't be more  than 15 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  height20,
                  TextFormField(
                    controller: emailController,
                    style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter email";
                      } else if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
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
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: bColor.withOpacity(0.5),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
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
                  TextFormField(
                    controller: confirmpasswordController,
                    style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                    obscureText: _isObscured1,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured1 ? Icons.visibility_off : Icons.visibility,
                          color: bColor.withOpacity(0.5),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured1 = !_isObscured1;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                  ),
                  height40,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customThemeButton("Signup", () {
                          if (_formKey.currentState!.validate()) {
                            // _loginMethod();
                          }
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
    fontSize: 13.sp, fontWeight: FontWeight.w600, color: themeColor)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
