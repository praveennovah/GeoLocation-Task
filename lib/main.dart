import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wheather(),
    );
  }
}

class Wheather extends StatefulWidget {
  const Wheather({super.key});

  @override
  State<Wheather> createState() => _WheatherState();
}

class _WheatherState extends State<Wheather> {
  String location = 'Chennai';
  var temp;
  var humidity;
  var feelslike;
  var windspeed;
  var wheather;

  Future get_wheather() async {
    var apiKey =
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d547942a8b4a402a40e8a9c85cc7c834&units=metric";

    http.Response response = await http.get(Uri.parse(apiKey));

    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.feelslike = result['main']['feels_like'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
      this.wheather = result['weather'][0]['description'];
    });
  }

  @override
  void initState() {
    this.get_wheather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Icon(
              Icons.sunny,
              color: Colors.orange,
              size: 80,
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: Text("$location")),
            SizedBox(
              height: 50,
            ),
            Center(child: Text("$temp\u00B0")),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FaIcon(FontAwesomeIcons.temperatureHalf),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Temperature",
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    trailing: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text("$temp")),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FaIcon(FontAwesomeIcons.wind),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child:
                          Text("WindSpeed", textDirection: TextDirection.ltr),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("$windspeed"),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FaIcon(FontAwesomeIcons.sun),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Humidity", textDirection: TextDirection.ltr),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("$humidity"),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FaIcon(FontAwesomeIcons.temperatureFull),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child:
                          Text("Feels Like", textDirection: TextDirection.ltr),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("$feelslike"),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FaIcon(FontAwesomeIcons.cloud),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Wheather", textDirection: TextDirection.ltr),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("$wheather"),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                    ),
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text("Get Location"),
                    onPressed: () {
                      this.get_wheather();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
