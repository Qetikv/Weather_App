import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    const String apiKey = 'e0f297c989ff4dc30be83cd9845cb2b5';
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
