import 'package:flutter/material.dart';

import '../place_details/place_overview.dart';


class HomeContainers extends StatelessWidget {
  const  HomeContainers({
    super.key,
    required this.places,
  });

  final List<Map<String, dynamic>> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: places.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourite(subtitle:places[index]['subtitle']!,
              name: places[index]['name']!,
              images: places[index]['images']!,
              about: places[index]['about']!,
              peakseason: places[index]['peak season']!,
              offseason: places[index]['off season'],


            )));
          },
          child: Container(
            width: 170,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white], // Change colors as needed
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
                    ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(15),bottom: Radius.circular(15)),
                        child: Image(image: AssetImage(places[index]['images']) ,fit: BoxFit.fitWidth,)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(places[index]['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(places[index]['location']!, style: TextStyle(color: Colors.grey)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${places[index]['price']}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              Text("${places[index]['days']} Days", style: TextStyle(color: Colors.grey)),
                            ],
                          ),

                        ],
                      ),
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