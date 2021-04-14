class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({this.description, this.icon});

  // gets description and icon from json
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TempInfo {
  final temp;

  TempInfo({this.temp});

  // gets temp from json
  factory TempInfo.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'];
    return TempInfo(temp: temp);
  }
}

class WeatherData {
  final DateTime date;
  final String name;
  final TempInfo temp;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherData({this.date, this.name, this.temp, this.weatherInfo});

  // brings all weather gathered together here
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final date = new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
        isUtc: false);

    final name = json['name'];

    // gets value from main which is the temp specified in TempInfo
    final tempInfoJson = json['main'];
    final tempInfo = TempInfo.fromJson(tempInfoJson);

    // gets values from weather which is icon and weather specified in WeatherInfo
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherData(
      date: date,
      name: name,
      temp: tempInfo,
      weatherInfo: weatherInfo,
    );
  }
}
