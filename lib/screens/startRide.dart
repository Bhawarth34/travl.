import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as Position;
import 'package:geolocator/geolocator.dart';

class startRide extends StatefulWidget{
  final String title;
  const startRide({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _startRide();

}

class _MapSuggestion{
  List<dynamic> _suggestions = [];


}


class _startRide extends State<startRide>{
  MapboxMap? mapboxMap;
  Position.Position? currLocation;
  List<dynamic> _suggestions = [];

  List<bool> isPressed = List.generate(3, (index)=>false);

  @override
  void initState() {
    _getLocation();
    super.initState();

  }

  void _getLocation() async{
    var position = await Geolocator.getCurrentPosition();

    setState(() {
      currLocation = Position.Position(position.longitude, position.latitude);
    });
  }

  // Map Suggestion

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    final String mapboxApiKey = "API FROM MAPBOX";

    final String url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$mapboxApiKey&autocomplete=true";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _suggestions = data['features'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MapboxOptions.setAccessToken("API FROM MAPBOX");
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title,
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Theme.of(context).primaryColor,
          ),
        )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(255,255,255,1),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 500,
                  child: currLocation == null
                      ? Center(child: CircularProgressIndicator()) // Show loader until location is fetched
                      : MapWidget(
                        onMapCreated: (controller) async {
                          mapboxMap = controller;

                          await mapboxMap?.location.updateSettings(
                            LocationComponentSettings(
                              enabled: true,  // Enables the blue dot
                              pulsingEnabled: true,  // Pulsing animation
                              showAccuracyRing: true,  // Shows accuracy circle
                              pulsingColor: Colors.blue.toARGB32(),  // Sets pulsing color to blue
                            ),
                          );

                          mapboxMap?.setCamera(
                            CameraOptions(
                              center: Point(coordinates: Position.Position(currLocation!.lng, currLocation!.lat)),
                              zoom: 14.0, // Adjust zoom level
                            ),
                          );
                        },
                      ),
                ),
                Positioned(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Color.fromRGBO(197, 197, 197, 1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )]
                      ),
                      child: Column(
                          children: [TextField(
                              onChanged: (value) => _fetchSuggestions(value),
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                prefixIcon: Icon(Icons.search,color: Colors.grey,),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                              ),
                              maxLines: 1,
                            ),
                            _suggestions.isNotEmpty
                                ? Container(
                              height: 200, // Limit list height
                              child: ListView.builder(
                                itemCount: _suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_suggestions[index]['place_name']),
                                    onTap: () {
                                      // Handle selection
                                      print("Selected: ${_suggestions[index]['place_name']}");
                                      controller.text = _suggestions[index]['place_name'];

                                      // You can also move the map to the selected location

                                      setState(() {
                                        _suggestions = [];
                                      });
                                    },
                                  );
                                },
                              ),
                            )
                                : Container(),
                        ]
                      ) ,
                    ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                    "Emergency Contacts",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  ),
                ),
                SizedBox(width: 75,),
                ElevatedButton(onPressed: (){print("hello");},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                        "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ))
              ]
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 239, 243,1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                    child: Column(
                      children: List.generate(3, (index) {
                        List<String> names = ["Mom", "Dad", "Brother"];
                        return Column
                      (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                names[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.location_on),
                                iconSize: 28,
                                color: (isPressed[index]) ? Colors.green : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    isPressed[index] = !isPressed[index];
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      );}),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }


}