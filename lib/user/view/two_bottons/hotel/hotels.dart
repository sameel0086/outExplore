import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/flegarship_string.dart';
import '../../../../utils/constants/popular_search.dart';
import '../../widget/flegarship_hotels.dart';



class HotelBooks extends StatefulWidget {
  @override
  State<HotelBooks> createState() => _HotelBooksState();
}

class _HotelBooksState extends State<HotelBooks> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  TextEditingController locationController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = checkInDate ?? DateTime.now();
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
          checkInDate = pickedDate;
          if (checkOutDate != null && checkOutDate!.isBefore(checkInDate!)) {
            checkOutDate = checkInDate!.add(Duration(days: 1));
          }
        } else {
          checkOutDate = pickedDate;
        }
      });
    }
  }

  String locationText = "Enter a city, hotel, or location";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch current location on load
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationText = "Location services are disabled.";
        isLoading = false;
      });
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationText = "Location permission denied.";
          isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationText = "Location permission permanently denied.";
        isLoading = false;
      });
      return;
    }

    try {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          locationText = "${place.locality}, ${place.administrativeArea}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        locationText = "Unable to get location";
        isLoading = false;
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
                onTap: () {
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
                      Icon(Icons.search_sharp,
                          color: Colors.blue), // Search Icon
                      SizedBox(width: 10),
                      Expanded(
                        child: isLoading
                            ? Text("Fetching location...")
                            : Text(
                                locationText,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),

                      // TextField(
                      //   controller: locationController,
                      //   decoration: InputDecoration(
                      //     hintText: "Enter a city, hotel, or location",
                      //     border: InputBorder.none,
                      //   ),
                      // ),
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
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            checkInDate == null
                                ? "Check in Dates"
                                : DateFormat('dd MMM yyyy').format(checkInDate!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            checkOutDate == null
                                ? "Check out Dates"
                                : DateFormat('dd MMM yyyy').format(checkOutDate!),
                          ),
                        ],
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
                  String location = locationController.text;
                  if (location.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a location")),
                    );
                  } else {
                    print("Searching for hotels in: $location");
                  }
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text('Flagship Hotel Stores',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33)),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              width: 350,
              child: FlegershipHotels(flegerhotels: flagshipHotels),
            ),
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
      builder: (context) {
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
                                  borderRadius: BorderRadius.circular(15))),
                        )),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.male_sharp),
                          TextButton(onPressed: () {

                          }, child: Text('Use Current Location'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "POPULAR SEARCH",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: popularCities.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
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
      }
      );
}
