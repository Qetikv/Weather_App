import 'package:flutter/material.dart';
import '../models/weather_app.dart';
import '../services/weather_api_service.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  Weather _weatherInfo =
      Weather(cityName: '', temperature: 0, weatherCondition: '');

  Future<void> _fetchWeather(String cityName) async {
    try {
      final Map<String, dynamic> data =
          await WeatherService.fetchWeather(cityName);
      final Weather weather = Weather.fromJson(data);
      setState(() {
        _weatherInfo = weather;
      });
    } catch (e) {
      setState(() {
        _weatherInfo = Weather(
            cityName: 'Unknown', temperature: 0, weatherCondition: 'Unknown');
      });
    }
  }

  // Function to get the weather image URL based on the weather condition
  String _getWeatherImageURL(String weatherCondition) {
    if (weatherCondition == 'Clear') {
      return 'assets/clear.png';
    } else if (weatherCondition == 'Clouds') {
      return 'assets/cloudy.png';
    } else if (weatherCondition == 'Rain') {
      return 'assets/rainy.png';
    } else {
      return 'assets/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Weather in Your City',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Enter a city name',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _fetchWeather(_cityController.text);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _weatherInfo.cityName.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'City: ${_weatherInfo.cityName}',
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),

                          ),
                          Text(
                            'Temperature: ${_weatherInfo.temperature.toStringAsFixed(0)}°C',
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                          ),
                          Text(
                            'Weather Condition: ${_weatherInfo.weatherCondition}',
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),

                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Image.asset(
                            _getWeatherImageURL(_weatherInfo.weatherCondition),
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
