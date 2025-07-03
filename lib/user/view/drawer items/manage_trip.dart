import 'package:flutter/material.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  MainTabPageState createState() => MainTabPageState();
}

class MainTabPageState extends State<MainTabPage>
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
    else if (index == 3) context = section4Key.currentContext;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Tab Page'),
        bottom: TabBar(
          controller: mainTabController,
          tabs: const [
            Tab(text: 'First'),
            Tab(text: 'Second'),
            Tab(text: 'Third'),
            Tab(text: 'Fourth'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              key: section1Key,
              child: FirstSubTabSection(),
            ),
            SizedBox(
                height: 400,
                child: Container(
                    key: section2Key,
                    color: Colors.red,
                    child: Center(
                        child: Text('Second Section',
                            style: TextStyle(fontSize: 24))))),
            SizedBox(
                height: 400,
                child: Container(
                    key: section3Key,
                    color: Colors.green,
                    child: Center(
                        child: Text('Third Section',
                            style: TextStyle(fontSize: 24))))),
            SizedBox(
                height: 400,
                child: Container(
                    key: section4Key,
                    color: Colors.blue,
                    child: Center(
                        child: Text('Fourth Section',
                            style: TextStyle(fontSize: 24))))),
          ],
        ),
      ),
    );
  }
}

class FirstSubTabSection extends StatefulWidget {
  const FirstSubTabSection({super.key});

  @override
  FirstSubTabSectionState createState() => FirstSubTabSectionState();
}

class FirstSubTabSectionState extends State<FirstSubTabSection>
    with SingleTickerProviderStateMixin {
  late TabController subTabController;

  @override
  void initState() {
    super.initState();
    subTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: subTabController,
          labelColor: Colors.black,
          tabs: const [
            Tab(text: 'Sub1'),
            Tab(text: 'Sub2'),
            Tab(text: 'Sub3'),
          ],
        ),
        Container(
          height: 300,
          child: TabBarView(
            controller: subTabController,
            children: const [
              Center(child: Text('SubTab 1 Content')),
              Center(child: Text('SubTab 2 Content')),
              Center(child: Text('SubTab 3 Content')),
            ],
          ),
        ),
      ],
    );
  }
}
// SizedBox(
//   height: 200, // Required to constrain ListView height
//   child: ListView(
//     scrollDirection: Axis.horizontal,
//     children: [
//       SizedBox(
//         width: 200,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.black),
//           ),
//           child: Center(child: Text(widget.peakseason)),
//         ),
//       ),
//       SizedBox(width: 10), // spacing
//       SizedBox(
//         width: 200,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.black),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.highlight_off),
//               // Center(child: Text(widget.offseason)),
//             ],
//           ),
//         ),
//       ),
//       SizedBox(width: 10), // spacing
//       SizedBox(
//         width: 200,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.black),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 "Festival And Events",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Center(child: Text(widget.offseason)),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),


