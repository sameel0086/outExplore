import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore dbs = FirebaseFirestore.instance;
  String regId = "";

// sign up
  Future<void> signUp(
      String email,
      String fullName,
      String password,
      String confirmPassword,
      String phoneNumber,
      ) async {
    //  set preference
    final preference = await SharedPreferences.getInstance();
    try {
      final Creds = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      regId = Creds.user!.uid;
      UserModel userModel = UserModel(
        id: regId,
        email: email,
        fullName: fullName,
        password: password,
        conformPassword: confirmPassword,
        phoneNumber: phoneNumber,
      );
      await dbs.collection("Users").doc(regId).set(userModel.tojson());

      preference.setString("regId", regId);
      print("user created with user $regId");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// sign in
  Future<void> SignIn(String email, String password) async {
    final preference = await SharedPreferences.getInstance();
    try {
      final Creds = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      regId = Creds.user!.uid;
      preference.setString("userId", regId);
      print("user login  with userid $regId");
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('no user that found that email');
        throw Exception("no user found for this email");
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        throw Exception("incorrect password.please try again");
      } else {
        print('authentication failed ${e.message}');
        throw Exception(e.message ?? "an unexpected error occurred");
      }
    }
  }

// sign out
  Future<void> signOut() async {
    final preference = await SharedPreferences.getInstance();
    preference.remove("userId");
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final preference = await SharedPreferences.getInstance();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("Google sign-in aborted");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      regId = userCredential.user!.uid;

      final userDoc = await dbs.collection("Users").doc(regId).get();

      // Save user data if signing in for the first time
      if (!userDoc.exists) {
        UserModel userModel = UserModel(
          id: regId,
          email: userCredential.user!.email ?? '',
          fullName: userCredential.user!.displayName ?? '',
          password: userCredential.user!.displayName ?? '',
          conformPassword: userCredential.user!.displayName ?? '',
          phoneNumber: userCredential.user!.displayName ?? '',
        );
        await dbs.collection("Users").doc(regId).set(userModel.tojson());
      }

      preference.setString("userId", regId);
      print("User signed in with Google: $regId");
      notifyListeners();
    } catch (e) {
      print("Google sign-in error: $e");
      throw Exception("Failed to sign in with Google");
    }
  }
}

//
// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   // Sign in to Firebase with the credential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
