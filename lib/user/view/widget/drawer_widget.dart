import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer items/manage_trip.dart';
import '../drawer items/notifications.dart';
import '../drawer items/profile.dart';
import '../drawer items/support.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor: Colors.white54,
      child:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            SizedBox(
              height: 150,
              width: 280,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text('profile'),),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 100,
              width: 280,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage ()));
                          }, icon: Column(
                            children: [
                              Icon(Icons.person_pin_sharp),
                              Text('My Account')
                            ],
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerSupport()));
                          }, icon: Column(
                            children: [
                              Icon(Icons.message),
                              Text('Support')
                            ],
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
                          }, icon: Column(
                            children: [
                              Icon(Icons.notifications_none),
                              Text('Notification')
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 150,
              width: 280,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                child:Column(
                  children: [
                    Text('My Trips'),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainTabPage()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.cases_outlined),
                          Text('View/Manage Trips'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>Whishlist()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.favorite_border),
                          Text('Whishlist'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 200,
              width: 280,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                child: Column(
                  children: [
                    Text('Rewards'),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScratchCardGrid()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.card_giftcard_outlined),
                          Text('Gift Card'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>InviteScreen()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.person_add_alt_sharp),
                          Text('Refer & Earn'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>HolidayPckages()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.male_sharp),
                          Text('Holidays'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 150,
              width: 280,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                child: Column(
                  children: [
                    Text('Settings'),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Fevarite()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.language),
                          Text('Language , country'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Fevarite(title: '',)));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.currency_exchange_sharp),
                          Text('Currency'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}