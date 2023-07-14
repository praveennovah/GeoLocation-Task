import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Position> getcurrentlocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service is Disapled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission Denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently Denied");
    }
    return await Geolocator.getCurrentPosition();
  }

  DateTime now = DateTime.now();

  late String lat;
  late String lon;
  String latMasg = "";
  String lonMasg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("location"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Date and Time:$now")),
          SizedBox(
            height: 50,
          ),
         
          Text(latMasg),
          Text(lonMasg),
           SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              getcurrentlocation().then((value) {
                lat = "${value.latitude}";
                lon = "${value.longitude}";
                setState(() {
                  latMasg = "Latitude: $lat";
                  lonMasg = "Longitude: $lon";
                });
              });
            },
            child: Text("Get Location"),
          ),
        ],
      ),
    );
  }
}
