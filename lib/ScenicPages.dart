import 'package:flutter/material.dart';
import 'package:travel_advisor/WeatherData.dart';
import 'package:travel_advisor/Weather.dart';
import 'package:travel_advisor/DataService.dart';
import 'package:travel_advisor/UploadData.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:travel_advisor/firebaseData.dart';
import 'firebaseData.dart';

class ScenicPages extends StatefulWidget {
  ScenicPages({this.app});
  final FirebaseApp app;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<ScenicPages>
    with SingleTickerProviderStateMixin {
  // State to show if loading up weather
  bool isLoading = false;

  WeatherData
      weatherData; // gets weather data from dataservice in async _getWeather function
  final _dataService = DataService(); // gets data from weather API
  var latitude;
  var longitude;
  int index = 0;

  final reference = FirebaseDatabase.instance.reference();
  DatabaseReference databaseReference;

  @override
  void initState() {
    print("Inside init state");
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    databaseReference = database.reference().child('Scenic Spots');
    print("end  init state");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Scenic Spots Page"),
          backgroundColor: Colors.grey[850]),
      backgroundColor: Colors.black,
      body: new Center(
        child: Column(
          children: [
            Flexible(
              child: new FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  latitude = snapshot.value['lat'];
                  longitude = snapshot.value['lon'];
                  // _getWeather();
                  index += 1;
                  return new Card(
                    color: Colors.brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    margin: EdgeInsets.all(7.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // image, name, weather, description widgets
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                snapshot.value['image'],
                                height: 140,
                                width: 140,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 15)),
                            new Flexible(
                              child: new Text(
                                snapshot.value['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 22),
                              ),
                            ),
                            // Weather
                            new Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: weatherData != null
                                    ? Weather(
                                        weather:
                                            weatherData) // Builds Weather widget
                                    : Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor: new AlwaysStoppedAnimation(
                                            Colors.blue),
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.teal,
                                            onPrimary: Colors.white),
                                        onPressed: _getWeather,
                                        child: Text('Get Weather'),
                                      ),
                              ),
                            ]),
                            // end Weather
                            Padding(padding: EdgeInsets.all(5)),
                          ],
                        ),
                        Row(children: <Widget>[
                          Padding(padding: EdgeInsets.all(5)),
                          new Flexible(
                            child: new Text(
                              snapshot.value['desc'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 18),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getWeather() async {
    setState(() => isLoading = true);

    // final lat = '44.4280';
    // final lon = '-110.5885';
    final lat = latitude;
    final lon = longitude;

    // decodes json file of weather data from weather API
    final weatherResponse = await _dataService.getWeather(lat, lon);

    // setState used because UI based on this response
    setState(() {
      weatherData = weatherResponse;
      isLoading = false;
    });
  }
}
