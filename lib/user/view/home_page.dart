import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampo/user/view/two_bottons/holiday_packages/main_page_holiday.dart';
import 'package:sampo/user/view/two_bottons/hotel_booking.dart';
import 'package:sampo/user/view/widget/drawer_widget.dart';
import 'package:sampo/user/view/widget/flegarship_hotels.dart';
import 'package:sampo/user/view/widget/home_containers.dart';
import 'package:sampo/user/view/widget/stay_hotels.dart';

import '../../utils/constants/flegarship_string.dart';
import '../../utils/constants/hotels_string.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/travel_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image(image: AssetImage(ImageStrings.logo)),
              ),
            ),
          ],
        ),
         drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        Text(
                          " hello \n parker",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 150),
                        IconButton(
                          onPressed: () {
                            // Navigator.push(context,MaterialPageRoute(builder: (context) => Notifications(),));
                          },
                          icon: Icon(Icons.notifications_none),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: const Text(
                    "Explore the\nBeautiful world!",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Discover your choice!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(),));
                      },
                      child: Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ], // Change colors as needed
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: Image(
                                image: AssetImage(
                                  'assets/logos/hotel_logo.jpg',
                                ),
                              ),
                            ),
                            Text('Hotels'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HolidayPckages(),));
                      },
                      child: Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ], // Change colors as needed
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 40,
                              child: Image(
                                image: AssetImage(
                                  'assets/logos/holiday_logo.jpg',
                                ),
                              ),
                            ),
                            Text('Holoday Packages'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            child: RotatedBox(
                              quarterTurns: 3, // Rotates the text vertically
                              child: TabBar(
                                labelColor: Colors.deepOrange,
                                unselectedLabelColor: Colors.blue,
                                tabs: [
                                  Tab(text: "Popular"),
                                  Tab(text: "Latest"),
                                  Tab(text: "All"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        child: TabBarView(
                          children: [
                            HomeContainers(places: popularPlaces),
                            HomeContainers(places: latestPlaces),
                            HomeContainers(places: allPlaces),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 150),
                  child: Text(
                    "Your stays..!",
                    style:
                    TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                ),
                // hotels widgets
                SizedBox(
                    height: 1000,
                    width: 350,
                    child: HotelStays(stayhotels: places2)),
                SizedBox(
                  height: 25,
                ),
                Text('Flagship Hotel Stores',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 33)),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  width: 350,
                  child:FlegershipHotels(flegerhotels: flagshipHotels) ,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Offers',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'viewAll',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 33),
                        )),
                    Icon(Icons.arrow_circle_right),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
