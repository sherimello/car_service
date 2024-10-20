import 'package:car_service/controllers/loading_controller.dart';
import 'package:car_service/functions/general_functions/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseFunctions {

SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<void> register(TextEditingController _emailController,
      TextEditingController _passwordController,
      TextEditingController _nameController,
      TextEditingController _phoneController,
      String role,
      LoadingController loadingController) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      print('User registered: ${userCredential.user!.uid}');

      String uid = userCredential.user!.uid;
      sharedPreferencesService.saveString(uid);

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
      loadingController.updateShouldShowLoadingOverlay();
      print('User registered and data saved: $uid');
      Get.snackbar("success!", "User registered and data saved: $uid", backgroundColor: Colors.white);
      // ... (navigation or other actions)
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

        // Show an error message to the user
        Get.snackbar("weak password", "The password provided is too weak.", backgroundColor: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // Show an error message to the user
        Get.snackbar(
            "user exists", "The account already exists for that email.", backgroundColor: Colors.white);
      }
    } catch (e) {
      print(e);
      // Show a generic error message to the user
      Get.snackbar("failed", "Failed to register.", backgroundColor: Colors.white);
    }
  }

  Future<void> signInWithEmailAndPassword(
      TextEditingController _emailController,
      TextEditingController _passwordController,
      LoadingController loadingController) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      // Sign-in successful, navigate to the next screen or perform other actions
      print('User signed in: ${userCredential.user!.uid}');

      sharedPreferencesService.saveString(userCredential.user!.uid);
      Get.snackbar("success", "User signed in: ${userCredential.user!.uid}", backgroundColor: Colors.white);
      loadingController.updateShouldShowLoadingOverlay();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        // Show an error message to the user
        Get.snackbar("error", "No user found for that email.", backgroundColor: Colors.white);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // Show an error message to the user
        Get.snackbar("error", "Wrong password provided for that user.", backgroundColor: Colors.white);
      }
    }
  }

  Future<void> addServiceToCloud(TextEditingController carNameController, serviceController, dateController) async{
    String uid = await sharedPreferencesService.getString("uid");
    DatabaseReference usersRef =
    FirebaseDatabase.instance.ref().child('orders');
    // Store user data in the database
    await usersRef.child(uid).push().set({
      'car_name': carNameController.text,
      'services': serviceController.text,
      'drop_off_date': dateController.text,
      'status': "in queue"
      // Add other user data as needed (e.g., username, profile picture URL)
    });
  }

}
