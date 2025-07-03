import 'package:flutter/material.dart';

import 'hotel/hotels.dart';
import 'hotel/hourly.dart';



class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hotels & Homestays"),
          bottom: TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Upto 4 Rooms"),
              Tab(text: "Hourly Stays"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HotelBooks(), // First Tab (Upto 4 Rooms)
            HourlyStays(), // Second Tab (Hourly Stays)
          ],
        ),
      ),
    );
  }
}