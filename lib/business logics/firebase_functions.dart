import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseFunctions {
  Future<void> register(TextEditingController _emailController,
      TextEditingController _passwordController,
      TextEditingController _nameController,
      TextEditingController _phoneController,
      String role) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      print('User registered: ${userCredential.user!.uid}');

      String uid = userCredential.user!.uid;

      // Create a reference to the Firebase Realtime Database
      DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child('users');

      // Store user data in the database
      await usersRef.child(uid).set({
        'email': _emailController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'role': role
        // Add other user data as needed (e.g., username, profile picture URL)
      });

      print('User registered and data saved: $uid');
      Get.snackbar("success!", "User registered and data saved: $uid");
      // ... (navigation or other actions)
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

        // Show an error message to the user
        Get.snackbar("weak password", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // Show an error message to the user
        Get.snackbar(
            "user exists", "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
      // Show a generic error message to the user
      Get.snackbar("failed", "Failed to register.");
    }
  }

  Future<void> signInWithEmailAndPassword(
      TextEditingController _emailController,
      TextEditingController _passwordController) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      // Sign-in successful, navigate to the next screen or perform other actions
      print('User signed in: ${userCredential.user!.uid}');
      Get.snackbar("success", "User signed in: ${userCredential.user!.uid}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        // Show an error message to the user
        Get.snackbar("error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // Show an error message to the user
        Get.snackbar("error", "Wrong password provided for that user.");
      }
    }
  }

}
