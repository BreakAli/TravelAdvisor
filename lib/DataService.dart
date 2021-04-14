import 'dart:convert';

import 'package:travel_advisor/WeatherData.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherData> getWeather(var lat, var lon) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    // final queryParameters = {
    //   'lat': lat,
    //   'lon': lon,
    //   'appid': '24f702748dfd5deebefa822ac29e0189',
    //   'units': 'imperial'
    // };

    // final uri = Uri.https(
    //     'api.openweathermap.org', '/data/2.5/forecast', queryParameters);
    // final uri = (
    // 'api.openweathermap.org/data/2.5/forecast?lat=44.4280&lon=110.5885&appid=24f702748dfd5deebefa822ac29e0189');

    // https://www.nps.gov/yell/planyourvisit/utms.htm can use this data to
    // get weather at different entrances

    // only gets current weather at Yellowstone's South Entrance in Teton
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=24f702748dfd5deebefa822ac29e0189&units=imperial');

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherData.fromJson(json);
  }
}
