import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSign extends StatefulWidget {
  const GoogleSign({super.key});

  @override
  State<GoogleSign> createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        currentUser = account;
      });
    });
    googleSignIn.signInSilently();
  }
  Future<void>handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  Future<void>handleSignOut() async {
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: currentUser != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
              NetworkImage(currentUser!.photoUrl ?? ''),
              radius: 40,
            ),
            SizedBox(height: 10),
            Text('Name: ${currentUser!.displayName ?? ''}'),
            Text('Email: ${currentUser!.email}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSignOut,
              child: Text('Sign Out'),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: handleSignIn,
          child: Text('Sign In with Google'),
        ),
      ),
    );
  }
}
