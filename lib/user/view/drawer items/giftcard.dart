import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';


class ScratchCardGrid extends StatefulWidget {
  const ScratchCardGrid({super.key});

  @override
  State<ScratchCardGrid> createState() => _ScratchCardGridState();
}

class _ScratchCardGridState extends State<ScratchCardGrid> {
  final List<GlobalKey<ScratcherState>> scratchKeys =
  List.generate(16, (_) => GlobalKey<ScratcherState>());

  final List<String> prizes = [
    "You Won ₹100!",
    "Better Luck Next Time!",
    "You Won ₹500!",
    "Free Coffee Coupon!",
    "You Won a Gift Card!",
    "Big Prize: ₹1000!",
    "You Won ₹200!",
    "Try Again!",
    "You Won a Movie Ticket!",
    "Special Bonus: ₹750!",
    "You Won ₹50!",
    "You Won a Free Lunch!",
    "You Won ₹300!",
    "You Won a Shopping Voucher!",
    "Better Luck Next Time!",
    "Grand Prize: ₹2000!",
  ];

  void showPrizeFlow(String prize) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(
              Icons.card_giftcard,
              size: 100,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/onboarding/my.png'),
                    radius: 25,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OutExplore",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Voucher",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Rewarded for completing a transaction",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              Text(
                prize,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OutExplore Rewards'),
        actions: [
          IconButton(
            onPressed: () {
              for (var key in scratchKeys) {
                key.currentState?.reset();
              }
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: scratchKeys.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Scratcher(
              key: scratchKeys[index],
              brushSize: 30,
              threshold: 50,
              onChange: (value) {
                print("Scratch progress on card $index: $value%");
              },
              onThreshold: () {
                print("Threshold reached on card $index!");
                showPrizeFlow(prizes[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // << Rounded corners here
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      prizes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
