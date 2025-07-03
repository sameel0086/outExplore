import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampo/user/authentication/controller/auth_controller.dart';
import 'package:sampo/user/authentication/controller/reg_controller.dart';
import 'package:sampo/user/bottom_screen.dart';

import '../../../utils/Validators/Reg_validator.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/themes/color_const.dart';
import 'Login_page.dart';

class RegisterPage extends StatefulWidget {
  const  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool regisPasswordVisible = false;
  bool regisConfirmPasswordVisible = false;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final RegistrationController controller = RegistrationController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: registerKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
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
                      'Welcome to outExplore',
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
                        Text(
                          'Continue with Google',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
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
                    controller: fullName,
                    validator: (value) =>
                        AppValidators().validator("full name", value),
                    decoration: InputDecoration(
                        labelText: 'enter your full name',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: email,
                      validator: (value) => controller.validateEmail(value),
                      decoration: InputDecoration(
                          labelText: 'enter your Email',
                          border: OutlineInputBorder()),
                    )),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => controller.validatePassword(value),
                      decoration: InputDecoration(
                          labelText: 'Creat password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              regisPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                regisPasswordVisible = !regisPasswordVisible;
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
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) => controller.validateConfirmPassword(
                          value, password.text),
                      decoration: InputDecoration(
                          labelText: 'Conform your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              regisConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                regisConfirmPasswordVisible =
                                !regisConfirmPasswordVisible;
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
                        if (registerKey.currentState!.validate()) {
                          authProvider.signUp(
                              email.text.trim(),
                              fullName.text,
                              password.text.trim(),
                              confirmPassword.text.trim(),
                              phoneNumber.text.trim());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomScreen()));
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('do you hava an aacount?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text(
                          'Log-in',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                              decorationColor: SColors.buttonColor,
                              color: SColors.buttonColor),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
