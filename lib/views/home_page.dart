import 'package:flutter/material.dart';
import '../models/weather_app.dart';
import '../services/weather_api_service.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherInfo = '';

  Future<void> _fetchWeather(String cityName) async {
    try {
      final Map<String, dynamic> data = await WeatherService.fetchWeather(cityName);
      final Weather weather = Weather.fromJson(data);
      setState(() {
        _weatherInfo = 'City: ${weather.cityName}, Temperature: ${weather.temperature.toStringAsFixed(0)}°C';
      });
    } catch (e) {
      setState(() {
        _weatherInfo = 'Failed to load weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter a city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _fetchWeather(_cityController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              _weatherInfo,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
