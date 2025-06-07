import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Controller/authController.dart';
import 'package:yellosky_assignment/Screens/Auth/signup_screen.dart';
import 'package:yellosky_assignment/Widget/customThemeButton.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
   bool _isObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter email";
                  //   } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  //       .hasMatch(value)) {
                  //     return "Enter Correct email";
                  //   } else {
                  //     return null;
                  //   }
                  // }, 
                 
                      validator: (val) => val!.isEmpty ? 'Enter email' : null,
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
                // customThemeButton("Login", () {
                //   if (_formKey.currentState!.validate()) {
                //   Authcontroller.loginUser(context: context, email: emailController.text, password: passwordController.text);
                //   }
                // }),
                Center(
                  child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                shape: RoundedRectangleBorder(
                                  
                                  borderRadius: BorderRadius.circular(8),
                                )
                              ),
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                                    Authcontroller.loginUser(context: context, email: emailController.text, password: passwordController.text);
                  
                                }
                              }, child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 28),
                                child: _isLoading? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: themeColor,
                                          strokeWidth: 2,
                                        ),
                                      ) as Widget :Text("Login",style: GoogleFonts.poppins(
                      fontSize: 12.sp, fontWeight: FontWeight.w600, color: wColor),),
                              )),
                ),
                                     
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
                        child:Text(
                          "Signup",
                          style:     GoogleFonts.poppins(
                                    fontSize: 13.sp, fontWeight: FontWeight.w600, color: themeColor),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}