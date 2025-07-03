import 'package:flutter/material.dart';

class ClickDestinations extends StatefulWidget {
  const ClickDestinations(
      {super.key,
      required this.destinationimage,
      required this.destinationname});

  final String destinationimage;
  final String destinationname;

  @override
  State<ClickDestinations> createState() => _ClickDestinationsState();
}

class _ClickDestinationsState extends State<ClickDestinations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                  ),
                  Icon(Icons.search_sharp),
                  Icon(Icons.share),
                  Icon(Icons.favorite_border)
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Image(
                    image: AssetImage(
                      widget.destinationimage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                width: 350,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)
                  ),
                child: Row(children: [
                  TextButton(onPressed: (){}, child: Text('Know the Destination')),
                TextButton(onPressed: (){}, child: Text('Photo Gallery'))
                ],),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  widget.destinationname,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ])));
  }
}
