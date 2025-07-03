import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/model/user_model.dart';
import '../view/register_page.dart';

class ProfileController extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  Stream<UserModel> getUserData() {
    final userId = fireAuth.currentUser?.uid;
    return db
        .collection("myUser")
        .doc(userId)
        .snapshots()
        .map((snap) => UserModel.fromjson(snap.data() ?? {}, deleteId: ''));
  }
  Future<void> editProfile (UserModel userModel) async{
    final userId = fireAuth.currentUser?.uid;
    await db.collection("myUser").doc(userId).update(userModel.tojson());
    notifyListeners();
  }
  Future<void>deleteProfile ({required context })async{
    final userId = fireAuth.currentUser?.uid;
    await db.collection("myUser").doc(userId).delete();
    try{
      final User?user=fireAuth.currentUser;
      if(user!=null){
        await user.delete();
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contaxt)=>RegisterPage(),),(route) => false, );
      }
    }
    catch(e){
      print(e);
    }
  }


}
