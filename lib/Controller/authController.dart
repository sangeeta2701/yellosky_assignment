import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellosky_assignment/Screens/Auth/login_screen.dart';
import 'package:yellosky_assignment/Screens/main_screen.dart';
import 'package:yellosky_assignment/Widget/showSnackbar.dart';

class Authcontroller {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //register user
  static Future<void> registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackbar(context, "All fields are required.");

      return;
    }

    if (password != confirmPassword) {
      showSnackbar(context, "Passwords do not match.");
      return;
    }

    if (password.length < 8 || password.length > 15) {
      showSnackbar(context, "Password must be 8-15 characters long.");
      return;
    }

    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      final uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email.trim(),
        'isProfileCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', uid); 

      showSnackbar(context, "Account created successfully!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    } catch (e) {
      showSnackbar(context, "Registration failed: ${e.toString()}");
    }
  }

  //login user
  static Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showSnackbar(context, "Please enter both email and password.");
      return;
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(email)) {
      showSnackbar(context, "Enter a valid email.");
      return;
    }

    if (password.length < 8 || password.length > 15) {
      showSnackbar(context, "Password must be 8-15 characters long.");
      return;
    }

    try {
  // Attempt login
  final userCredential = await _auth.signInWithEmailAndPassword(
    email: email.trim(),
    password: password.trim(),
  );

  final uid = userCredential.user?.uid;

  if (uid == null) {
    showSnackbar(context, "User ID not found. Please try again.");
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('uid', uid);

  // Navigate to MainScreen on success
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => MainScreen()),
  );
} on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      } else if (e.code == 'invalid-credential') {
        errorMessage = "Invalid email or password.";
      } else {
        errorMessage = e.message ?? "Unknown error occurred.";
      }

      // Show error message
      showSnackbar(context, errorMessage);
    } catch (e) {
      showSnackbar(context, "Unexpected error: ${e.toString()}");
    }
  }

  //logout
  static Future<void> logoutUser(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    showSnackbar(context, "Logout Successful");

    // Navigate back to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }
}
