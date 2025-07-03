import 'package:flutter/material.dart';

class SearchClick extends StatefulWidget {
  const SearchClick(
      {super.key,
      required this.searchImage,
      required this.searchTitle,
      required this.searchDesc,
      required this.season});

  final String searchImage;
  final String searchTitle;
  final String searchDesc;
  final String season;

  @override
  State<SearchClick> createState() => _SearchClickState();
}

class _SearchClickState extends State<SearchClick> {
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
                  widget.searchImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              widget.searchTitle,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              widget.searchDesc,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              widget.season,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ])));
  }
}
