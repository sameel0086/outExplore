import 'package:flutter/material.dart';


import '../place_details/click_search_place_.dart';

class SearchContainers extends StatelessWidget {
  const SearchContainers({
    super.key,
    required this.searchPlace,
  });

  final List<Map<String, dynamic>> searchPlace;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: searchPlace.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchClick(
                    searchImage: searchPlace[index]['search image'],
                    searchTitle: searchPlace[index]['search title'],
                    searchDesc: searchPlace[index]['search desc'],
                    season: searchPlace[index]['season'],
                  ),
                ));
          },
          child: Container(
            width: 170,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.white
                ], // Change colors as needed
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(15)),
                        child: Image(
                          image: AssetImage(searchPlace[index]['search image']),
                          fit: BoxFit.fitWidth,
                        )),
                    Column(
                      children: [
                        Text(searchPlace[index]['search title']!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(searchPlace[index]['search desc']!,
                            style: TextStyle(color: Colors.grey)),
                        Text("\$${searchPlace[index]['season']}",
                            style: TextStyle(
                              color: Colors.green,
                            )),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
