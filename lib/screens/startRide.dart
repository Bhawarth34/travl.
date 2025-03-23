import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:geolocator/geolocator.dart';

class startRide extends StatefulWidget{
  final String title;
  const startRide({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _startRide();

}

class _startRide extends State<startRide>{
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late LatLng currLocation;

  List<bool> isPressed = List.generate(3, (index)=>false);

  @override
  void initState() {
    _getLocation();
    super.initState();

  }

  void _getLocation() async{
    var position = await Geolocator.getCurrentPosition();

    setState(() {
      currLocation = LatLng(position.latitude, position.longitude);
    });
  }


  @override
  Widget build(BuildContext context) {

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
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: currLocation,
                      zoom: 15,),
                    onCameraMove: (CameraPosition cameraPosition){print(cameraPosition.zoom);},
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
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
                      child: GooglePlacesAutoCompleteTextFormField(
                        decoration: InputDecoration(
                          hintText: "Where to?",
                          prefixIcon: Icon(Icons.search,color: Colors.grey,),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                        ),
                        maxLines: 1,
                        googleAPIKey: 'AIzaSyCRjIBOKuPepqQ0CGcp2g9SQ1jBNqJtZT8',
                        fetchCoordinates: true,
                        onPlaceDetailsWithCoordinatesReceived: (coordinates){
                          print("${coordinates.lat} ${coordinates.lng}");
                        },
                        onSuggestionClicked: (coordinates){
                          controller.text = coordinates.description!;
                          controller.selection = TextSelection.fromPosition(TextPosition(offset: coordinates.description!.length));
                        },
                      ),
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
                    child: List.generate(3, (index) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mom",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.location_on),
                                    iconSize: 28,
                                    color: (isPressed)?Colors.green: Colors.grey,
                                    onPressed: () { setState(() {
                                      if(isPressed){
                                        isPressed=false;
                                      }
                                      else {
                                        isPressed = true;
                                      }
                                    }
                                    );},
                                  ),
                                ],
                              ),
                          SizedBox(height: 10,),
                      ],),
                    ),
                  ),
                ]
              ),
            ),
          ]
        ),
      )
    );
  }


}