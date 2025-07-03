import 'package:flutter/material.dart';

class FlegarshiClicks extends StatefulWidget {
  const FlegarshiClicks(
      {super.key,
      required this.name,
      required this.images,
      required this.location,
      required this.about});

  final String images;
  final String name;
  final String location;
  final String about;

  @override
  State<FlegarshiClicks> createState() => _FlegarshiClicksState();
}

class _FlegarshiClicksState extends State<FlegarshiClicks> {
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
                  widget.images,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text(
                  widget.location,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                widget.about,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontWeight: FontWeight.w800),
              ),
        ])));
  }
}
