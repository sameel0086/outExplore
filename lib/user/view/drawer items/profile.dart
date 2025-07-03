// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class ProfilePage extends StatelessWidget {
// //   final String userId;
// //
// //   const ProfilePage({required this.userId, super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final firestore = FirebaseFirestore.instance;
// //
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Profile')),
// //       body: FutureBuilder<DocumentSnapshot>(
// //         future: firestore.collection('Users').doc(userId).get(),
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
// //
// //           final data = snapshot.data!.data() as Map<String, dynamic>;
// //
// //           return Padding(
// //             padding: EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text("Full Name: ${data['fullName']}", style: TextStyle(fontSize: 18)),
// //                 Text("Email: ${data['email']}", style: TextStyle(fontSize: 18)),
// //                 Text("Phone: ${data['phoneNumber']}", style: TextStyle(fontSize: 18)),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../authentication/controller/profile_controller.dart';
// import '../../authentication/model/user_model.dart';
//
// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   TextEditingController fullnamecontroller = TextEditingController();
//   TextEditingController emailcontroler = TextEditingController();
//   TextEditingController passcontroler = TextEditingController();
//   TextEditingController conformpasscontroler = TextEditingController();
//   TextEditingController phonenumbercontroller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<ProfileController>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("your profile")),
//       body: StreamBuilder<UserModel>(
//         stream: userProvider.getUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: Text("No data"));
//           }
//           final data = snapshot.data;
//           return Column(
//             children: [
//               Stack(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.redAccent,
//                     radius: 70,
//                     child: Text(
//                       data!.fullName[0].toUpperCase(),
//                       style: TextStyle(fontSize: 100),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.lightGreenAccent,
//                       child: IconButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               TextEditingController fullnamecontroller =
//                                   TextEditingController(text: data.fullName);
//
//                               TextEditingController emailcontroler =
//                                   TextEditingController(text: data.email);
//
//                               return AlertDialog(
//                                 title: Text("edit profile"),
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     TextFormField(
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "first name not fond";
//                                         }
//                                       },
//                                       controller: fullnamecontroller,
//                                       decoration: InputDecoration(
//                                         labelText: "fullName",
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//
//                                     SizedBox(height: 10),
//                                     TextFormField(
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "email not fond";
//                                         }
//                                       },
//                                       controller: emailcontroler,
//                                       decoration: InputDecoration(
//                                         labelText: "email",
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                   ],
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("cancel"),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       final updateProfile = UserModel(
//                                         id: "",
//                                         email: emailcontroler.text,
//                                         fullName: fullnamecontroller.text,
//                                         phoneNumber: phonenumbercontroller.text,
//                                         password: passcontroler.text,
//                                           conformPassword: conformpasscontroler.text
//
//                                       );
//
//                                       userProvider.editProfile(updateProfile);
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text("save"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         icon: Icon(Icons.edit),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
//               Container(
//                 height: 50,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.withOpacity(0.5)),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 0),
//                       color: Color(0xFFB7B7B7),
//                       spreadRadius: 3,
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 // color: Colors.yellow,
//                 child: Column(
//                   children: [Text("fullName"), Text(data.fullName)],
//                 ),
//               ),
//               SizedBox(height: 30),
//
//               SizedBox(height: 30),
//               Container(
//                 height: 50,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.withOpacity(0.5)),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 0),
//                       color: Color(0xFFB7B7B7),
//                       spreadRadius: 3,
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 // color: Colors.yellow,
//                 child: Column(children: [Text("email"), Text(data.email)]),
//               ),
//               SizedBox(height: 30),
//
//               SizedBox(height: 50),
//               ElevatedButton(
//                 onPressed: () {
//                   userProvider.deleteProfile(context: context);
//                 },
//                 child: Text("delete"),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('Users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  Future<void> updateProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).update({
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneController.text,
      });
      Navigator.pop(context);
      fetchUserData();
    }
  }

  Future<void> deleteProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).delete();
      await user.delete(); // Also deletes from FirebaseAuth
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile deleted")));
      // Optionally, navigate to login or welcome screen
    }
  }

  void showEditDialog() {
    fullNameController.text = userData?['fullName'] ?? '';
    emailController.text = userData?['email'] ?? '';
    phoneController.text = userData?['phoneNumber'] ?? '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: updateProfile, child: const Text("Save")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteProfile,
          ),
        ],
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                (userData?['fullName'] ?? 'U')[0].toUpperCase(),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            Text("Full Name: ${userData!['fullName']}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${userData!['email']}", style: const TextStyle(fontSize: 18)),
            Text("Phone: ${userData!['phoneNumber']}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
