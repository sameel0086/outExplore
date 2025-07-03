import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../../../utils/constants/hotels_string.dart';
import '../../../../utils/constants/popular_search.dart';
import '../../widget/stay_hotels.dart';

class HourlyStays extends StatefulWidget {
  @override
  State<HourlyStays> createState() => _HourlyStaysState();
}

class _HourlyStaysState extends State<HourlyStays> {
  DateTime? selectInDate;
  DateTime? selectOutDate;
  TextEditingController locationStayController = TextEditingController();

  Future<void> selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = selectInDate ?? DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now().add(Duration(days: 365));

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          selectInDate = pickedDate;
          if (selectOutDate != null && selectOutDate!.isBefore(selectInDate!)) {
            selectOutDate = selectInDate!.add(Duration(days: 1));
          }
        } else {
          selectOutDate = pickedDate;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
              child: InkWell(
                onTap: (){
                  buildShowModalBottomSheet(context);

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_sharp, color: Colors.blue), // Search Icon
                      SizedBox(width: 10),
                      Text("Enter a city, hotel, or location ")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        selectInDate == null
                            ? "Check-in Date"
                            : DateFormat('dd MMM yyyy').format(selectInDate!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        selectOutDate == null
                            ? "Check-out Date"
                            : DateFormat('dd MMM yyyy').format(selectOutDate!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Change button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
                onPressed: () {
                  String location = locationStayController.text;
                  if (location.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a location")),
                    );
                  } else {
                    print("Searching for hotels in: $location");
                  }
                },
                child: Text("Search",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Text(
                "Your stays..!",
                style:
                TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
              ),
            ),
            // hotels widgets
            SizedBox(
                height: 1000,
                width: 350,
                child: HotelStays(stayhotels: places2)),

          ],
        ),
      ),
    );
  }
}
buildShowModalBottomSheet(BuildContext context) {

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Where you want to stay ?',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "POPULAR SEARCH",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: popularCities.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final city = popularCities[index]['city']!;
                      final country = popularCities[index]['country']!;
                      return ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        title: Text(city),
                        subtitle: Text(country),

                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  });

}