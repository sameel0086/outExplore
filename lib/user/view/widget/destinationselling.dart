import 'package:flutter/material.dart';


import '../../../utils/constants/destinations.dart';
import '../place_details/click_destinations.dart';


class DestinationSelling extends StatelessWidget {
  const DestinationSelling({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClickDestinations(destinationimage: destination['image'],destinationname: destination['name'],),));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 90,
              child:Column(
                children: [
                  ClipOval(
                    child: Image(
                      image: AssetImage(destination['image']!),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    destination['name']!,
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}