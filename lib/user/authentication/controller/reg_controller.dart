import 'package:flutter/material.dart';

import '../../../utils/Validators/Reg_validator.dart';



class RegistrationController {
  final RegistrationModel model = RegistrationModel();


  String? validateEmail(String? value) => model.validateEmail(value);
  String? validatePassword(String? value) => model.validatePassword(value);
  String? validateConfirmPassword(String? value, String password) =>
      model.validateConfirmPassword(value, password);

  // Perform Registration (simplified)
  void register(BuildContext context, GlobalKey<FormState> registerKey, String name, String email, String password, String confirmPassword) {
    if (registerKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
    }
  }
  void Signin(BuildContext context, GlobalKey<FormState> registerKey, String email, String password) {
    if (registerKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
    }
  }
}