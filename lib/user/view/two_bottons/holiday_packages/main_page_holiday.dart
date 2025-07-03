import 'package:flutter/material.dart';

import '../../Bottamsheets/holiday_packages/persons_check.dart';
import '../../widget/destinationselling.dart';


class HolidayPckages extends StatefulWidget {
  const HolidayPckages({super.key});

  @override
  State<HolidayPckages> createState() => _HolidayPckagesState();
}

class _HolidayPckagesState extends State<HolidayPckages> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Holiday Packages',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('India and International'),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: InkWell(
                onTap:  (){
                  TravelingFromBottomSheet(context);

                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        'STARTING FROM',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: InkWell(
                onTap:  (){
                  TravelingToBottomSheet(context);

                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        'TRAVELLING TO 66',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'STARTING DATE',
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                                Text(
                                  selectedDate != null
                                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                      : "Select date",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () => openPersonsBottomSheet(context),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ROOMS & GUESTS',
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                  Text(
                                    '${selectedRooms.length} Room(s), ${getTotalGuests()} Guest(s)',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )


              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Change button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'SEARCH',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Best Selling Destination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            DestinationSelling(),
          ],
        ),
      ),
    );
  }
}


TravelingFromBottomSheet(BuildContext context) {

  return showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      isScrollControlled: true, // Important for full height control
      builder: (context)
      {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            // 60% of screen height
            minChildSize: 0.3,
            maxChildSize: 0.95,
            // Allow it to grow up to 95%
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
        );
      }
    );});
  }
TravelingToBottomSheet(BuildContext context) {

  return showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      isScrollControlled: true, // Important for full height control
      builder: (context)
      {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            // 60% of screen height
            minChildSize: 0.3,
            maxChildSize: 0.95,
            // Allow it to grow up to 95%
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
        );
      }
  );});
}

