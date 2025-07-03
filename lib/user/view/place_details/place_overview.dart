import 'package:flutter/material.dart';
import 'package:sampo/user/view/place_details/pick_stories_page.dart';

import '../search_page.dart';
import '../two_bottons/holiday_packages/main_page_holiday.dart';

class Favourite extends StatefulWidget {
  const Favourite({
    super.key,
    required this.name,
    required this.images,
    required this.subtitle,
    required this.about,
    required this.peakseason,
    required this.offseason,
  });
  final String name;
  final String images;
  final String subtitle;
  final String about;
  final String peakseason;
  final String offseason;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>
    with SingleTickerProviderStateMixin {
  late TabController mainTabController;
  final ScrollController scrollController = ScrollController();

  final GlobalKey section1Key = GlobalKey();
  final GlobalKey section2Key = GlobalKey();
  final GlobalKey section3Key = GlobalKey();
  final GlobalKey section4Key = GlobalKey();

  bool isTabTapped = false;

  @override
  void initState() {
    super.initState();
    mainTabController = TabController(length: 4, vsync: this);

    mainTabController.addListener(() {
      if (mainTabController.indexIsChanging) {
        isTabTapped = true;
        scrollToSection(mainTabController.index);
      }
    });

    scrollController.addListener(handleScroll);
  }

  void handleScroll() {
    if (isTabTapped) return;

    final positions = [
      getOffset(section1Key),
      getOffset(section2Key),
      getOffset(section3Key),
      getOffset(section4Key),
    ];

    final currentScroll = scrollController.offset + 100;

    for (int i = 0; i < positions.length; i++) {
      if (currentScroll < positions[i]) {
        mainTabController.animateTo(i - 1 < 0 ? 0 : i - 1);
        return;
      }
    }
    mainTabController.animateTo(3);
  }

  double getOffset(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      final box = ctx.findRenderObject() as RenderBox;
      return box.localToGlobal(Offset.zero, ancestor: null).dy +
          scrollController.offset;
    }
    return double.infinity;
  }

  void scrollToSection(int index) {
    BuildContext? context;
    if (index == 0)
      context = section1Key.currentContext;
    else if (index == 1)
      context = section2Key.currentContext;
    else if (index == 2)
      context = section3Key.currentContext;
    else if (index == 3)
      context = section4Key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ).then((value) {
        isTabTapped = false;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    mainTabController.dispose();
    super.dispose();
  }

  int currentPage = 0;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 120),
                  Icon(Icons.search_sharp),
                  Icon(Icons.share),
                  Icon(Icons.favorite_border),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Column(
                key: section1Key,
                children: [
                  SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Image(
                        image: AssetImage(widget.images),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  TabBar(
                    controller: mainTabController,
                    tabs: const [
                      Tab(text: 'overview'),
                      Tab(text: 'ToDo'),
                      Tab(text: 'book'),
                      Tab(text: 'taravel stories'),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 400,
                    width: 350,
                    child: Column(
                      children: [
                        Text(
                          widget.about,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Best Time to Visit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    key: section2Key,
                    child: SearchPlace(),
                  ),

                  SizedBox(
                    height: 1000,
                    child: Container(
                      key: section3Key,
                      color: Colors.green,
                      child: Center(child: HolidayPckages()),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: Container(
                      key: section4Key,
                      color: Colors.green,
                      child: Center(child: MultiImagePickerPage()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
