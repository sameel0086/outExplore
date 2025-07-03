
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sampo/user/view/home_page.dart';
import 'package:sampo/user/view/search_page.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  PageController pageCount = PageController();
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int currentIndex = 0;
  final List<Widget> screens = [
    Center(
      child: HomePage(),
    ),
    Center(
       child:  SearchPage(),
    ),
    Center(
      // child:GoogleMapScreen(),
    ),
    Center(
      // child:Whishlist (),
    ),
    Center(

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        backgroundColor: Colors.black,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.search_sharp, size: 30),
          Icon(Icons.explore_rounded, size: 30),
          Icon(Icons.favorite_border, size: 30),
          Icon(Icons.manage_history_rounded, size: 30),
        ],
        animationDuration: Duration(milliseconds: 300),
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: screens[currentIndex],
    );
  }
}