import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          SizedBox(
            height: 20,
            width: 350,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Text("Notification",),
            ),
          )
        ],
      ),
    );
  }
}
