import 'package:flutter/material.dart';

class _RoomGuestSelectorContent extends StatefulWidget {
  final ScrollController scrollController;
  final List<Map<String, int>> initialRooms;

  const _RoomGuestSelectorContent({
    required this.scrollController,
    required this.initialRooms,
  });

  @override
  State<_RoomGuestSelectorContent> createState() => _RoomGuestSelectorContentState();
}

class _RoomGuestSelectorContentState extends State<_RoomGuestSelectorContent> {
  late List<Map<String, int>> rooms;

  final int maxGuestsPerRoom = 4;

  @override
  void initState() {
    super.initState();
    rooms = List<Map<String, int>>.from(widget.initialRooms);
  }

  void _addRoom() {
    setState(() {
      rooms.add({"adults": 2, "children": 0});
    });
  }

  void _increment(String type, int index) {
    setState(() {
      int totalGuests = rooms[index]["adults"]! + rooms[index]["children"]!;
      if (totalGuests < maxGuestsPerRoom) {
        rooms[index][type] = rooms[index][type]! + 1;
      }
    });
  }

  void _decrement(String type, int index) {
    setState(() {
      if (rooms[index][type]! > 0) {
        rooms[index][type] = rooms[index][type]! - 1;
      }
    });
  }

  Widget _buildCounter(String title, String subtitle, String type, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ]),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => _decrement(type, index),
            ),
            Text('${rooms[index][type]}', style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _increment(type, index),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRoomCard(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index == 0)
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: RichText(
                text: TextSpan(
                  text: "Maximum ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "4 Guests ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: "are allowed in this room"),
                  ],
                ),
              ),
            ),
          Text("ROOM ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _buildCounter("Adults", "Above 12 Years", "adults", index),
          _buildCounter("Children", "Below 12 Years", "children", index),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 12),
          Text("Select Rooms & Guests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: rooms.length,
              itemBuilder: (context, index) => _buildRoomCard(index),
            ),
          ),
          TextButton(
            onPressed: _addRoom,
            child: Text(
              "+ ADD ANOTHER ROOM",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          if (rooms.length > 1)
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.removeLast();
                });
              },
              child: Text(
                "- REMOVE LAST ROOM",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, rooms); // ✅ Return updated room data
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.blue,
              ),
              child: Text("APPLY", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
List<Map<String, int>> selectedRooms = [
  {"adults": 2, "children": 0}
];

void openPersonsBottomSheet(BuildContext context) async {
  final result = await showModalBottomSheet<List<Map<String, int>>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return _RoomGuestSelectorContent(
            scrollController: scrollController,
            initialRooms: selectedRooms,
          );
        },
      );
    },
  );

  if (result != null) {
    selectedRooms = result;
  }
}

int getTotalGuests() {
  return selectedRooms.fold(0, (sum, room) => sum + room['adults']! + room['children']!);
}
