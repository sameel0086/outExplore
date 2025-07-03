
import 'package:flutter/material.dart';


class HotelDetail extends StatefulWidget {
  const HotelDetail(
      {super.key,
        required this.name,
        required this.images,

        });
  final String name;
  final String images;



  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  int currentPage = 0;
  TextEditingController controller = TextEditingController();
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
          child: Column(
            children: [
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
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),


              SizedBox(height: 20,),

            ],
          ),
        ));
  }
}
