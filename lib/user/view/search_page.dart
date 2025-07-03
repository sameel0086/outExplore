import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampo/user/view/widget/search_container.dart';
import 'package:sampo/utils/constants/image_strings.dart';

import '../../utils/constants/travel_string.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController subTabController;

  @override
  void initState() {
    super.initState();
    subTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 30),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CarouselSlider(
                        items: ImageStrings.imageList
                            .map(
                              (item) => Container(
                                height: 400,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    height: 400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                        ),
                      ),
                      Positioned(
                        top: 190,
                        left: 15,
                        right: 15,
                        child: SizedBox(
                          width: 350,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.search_sharp),
                              hintText: 'Where are you going?',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 80,
                        left: 15,
                        right: 0,
                        child: Column(
                          children: [
                            Text(
                              'Discover your next travel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'destination',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Travel Stories & Inspirations',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  SearchPlace(),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPlace extends StatefulWidget {
  const SearchPlace({
    super.key});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace>
    with SingleTickerProviderStateMixin {
  late TabController subTabController;

  @override
  void initState() {
    super.initState();
    subTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the tabs
            children: [
              Expanded(
                child: TabBar(
                  controller: subTabController,
                  labelColor: Colors.deepOrange,
                  unselectedLabelColor: Colors.blue,
                  indicatorColor: Colors
                      .deepOrange, // Optional: Adds an indicator color
                  tabs: [
                    Tab(text: "Recommended"),
                    Tab(text: "Trending"),
                    Tab(text: "Weekend"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: TabBarView(
              controller: subTabController,
              children: [
                SearchContainers(searchPlace: Recommented),
                SearchContainers(searchPlace: trending),
                SearchContainers(searchPlace: weekend),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
