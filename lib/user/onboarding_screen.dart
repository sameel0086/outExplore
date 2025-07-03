import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/constants/image_strings.dart';
import '../utils/themes/color_const.dart';
import 'authentication/view/Login_page.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController pageCount = PageController();
  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (pageIndex < 2) {
              pageIndex += 1;
              pageCount.jumpToPage(pageIndex);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  LoginPage()),
              );
            }
          });
        },
        backgroundColor: Colors.red,
        child: Icon(pageIndex == 2 ? Icons.check_rounded : Icons.arrow_forward),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageCount,
            onPageChanged: (index) {
              pageIndex = index;
              setState(() {});
            },
            children: [
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6), // Shadow color
                            blurRadius: 20, // Blur intensity
                            spreadRadius: 5, // Spread size
                            offset: const Offset(5, 5), // Shadow direction
                          ),
                        ],
                      )),
                  Image(
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage(
                          ImageStrings.onboard1
                      )),
                  Positioned(top: 60,left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,width: 70,
                            child: Image(image: AssetImage(ImageStrings.logo))),
                        Text(
                          'outExplore',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Positioned(bottom: 150,
                      child: Text("  Explore your \n  intrest",style: TextStyle(fontSize: 35,color: SColors.primaryColor,fontWeight: FontWeight.w800,)))
                ],
              ),
              Stack(
                children: [
                  Image(
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage(
                          ImageStrings.onboard2
                      )),
                  Positioned(top: 60,left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,width: 70,
                            child: Image(image: AssetImage(ImageStrings.logo))),
                        Text(
                          'outExplore',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Positioned(bottom: 150,
                      child: Text(" Find your \n Travel Mate",style: TextStyle(fontSize: 35,color: SColors.primaryColor,fontWeight: FontWeight.w800,)))
                ],
              ),
              Stack(
                children: [
                  Image(
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage(
                          ImageStrings.onboard3
                      )),
                  Positioned(top: 60,left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,width: 70,
                            child: Image(image: AssetImage(ImageStrings.logo))),
                        Text(
                          'outExplore',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Positioned(bottom: 150,
                      child: Text(" Plan your \n Trip",style: TextStyle(fontSize: 35,color: SColors.primaryColor,fontWeight: FontWeight.w800,)))
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageCount,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
}
