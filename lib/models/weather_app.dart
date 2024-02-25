// lib/models/weather_model.dart
class Weather {
  final String cityName;
  final double temperature;

  Weather({required this.cityName, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15),
    );
  }
}
