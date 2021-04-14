import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_advisor/WeatherData.dart';

// Youtube video that helped me create the Weather App
// https://www.youtube.com/watch?v=5fzdvPnp5bY
class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name,
            style: new TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(weather.weatherInfo.description,
            style: new TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey)),
        Text('${weather.temp.temp}°F',
            style: new TextStyle(fontSize: 16.0, color: Colors.white)),
        // Image.network(weather.iconUrl),
        Text(new DateFormat.yMMMd().format(weather.date),
            style: new TextStyle(color: Colors.white)),
        Text(new DateFormat.Hm().format(weather.date),
            style: new TextStyle(color: Colors.white)),
      ],
    );
  }
}
