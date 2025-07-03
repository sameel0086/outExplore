import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampo/user/authentication/controller/app_controller.dart';
import 'package:sampo/user/authentication/controller/auth_controller.dart';
import 'package:sampo/user/authentication/controller/profile_controller.dart';
import 'package:sampo/user/authentication/view/Login_page.dart';
import 'package:sampo/user/bottom_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'firebase_options.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );
  final preference = await SharedPreferences.getInstance();
  final String? uid = preference.getString("regId");

  runApp(MyApp(regId: uid));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,this.regId});
  final String? regId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => AppController(),),
        ChangeNotifierProvider(create: (context) => ProfileController(),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
         home: (regId!= null && regId!.isNotEmpty) ? BottomScreen() :    LoginPage(),
      ),
    );
  }
}

