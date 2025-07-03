import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';


class AppController extends ChangeNotifier {
  final FirebaseFirestore myfirestore = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  Future<void> saveData(UserModel taskData) async {
    final userId = fireAuth.currentUser?.uid;
    if (userId == null) {
      print("mo user found");
    }
    try {
      await myfirestore
          .collection("myUser")
          .doc(userId)
          .collection("tasks")
          .add(taskData.tojson());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<UserModel>> getData() {
    final userId = fireAuth.currentUser?.uid;
    if (userId == null) {
      return Stream.empty();
    }
    return myfirestore
        .collection("myUser")
        .doc(userId)
        .collection("tasks")
        .orderBy("time", descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => UserModel.fromjson(doc.data(),deleteId: doc.id))
        .toList());
  }

  deleteData(String deleteId) async {
    final userId = fireAuth.currentUser?.uid;
    await myfirestore
        .collection("myUser")
        .doc(userId)
        .collection("tasks")
        .doc(deleteId)
        .delete();
    notifyListeners();
  }

  Future<void> editId(UserModel taskData, String deleteId) async {
    final userId = fireAuth.currentUser?.uid;
    try {
      await myfirestore
          .collection("myUser")
          .doc(userId)
          .collection("tasks")
          .doc(deleteId)
          .update(taskData.tojson());
      notifyListeners();
      print("user updated successfully");
    } catch (e) {
      print("Error updating user:$e");
    }
  }
}
