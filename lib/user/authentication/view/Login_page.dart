import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';
import 'package:sampo/user/authentication/controller/auth_controller.dart';
import 'package:sampo/user/authentication/view/register_page.dart';
import 'package:sampo/user/bottom_screen.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/themes/color_const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
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
    final authProvider = Provider.of<AuthController>(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: loginKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 70,
                          child: Image(image: AssetImage(ImageStrings.logo))),
                      Text(
                        'Sing in outExplore',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: AssetImage(ImageStrings.googlelogo)),
                          SizedBox(
                            width: 5,
                          ),
                    Center(
                      child: currentUser != null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          : InkWell(onTap: () {
                        handleSignIn();
                      },
                         child:  Text(
                            'Continue with Google',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "OR",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 300,
                      child: TextFormField(
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(350, 50),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          if (loginKey.currentState!.validate()) {
                            try {
                              authProvider.SignIn(
                                  email.text.trim(), password.text.trim());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomScreen()));
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Failed'),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "register in outExplore",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            decorationColor: SColors.buttonColor,
                            color: SColors.buttonColor),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reset password",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            decorationColor: SColors.buttonColor,
                            color: SColors.buttonColor),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "register in outExplore",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                decorationColor: SColors.buttonColor,
                                color: SColors.buttonColor),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
