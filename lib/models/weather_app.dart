class Weather {
  final String cityName;
  final double temperature;
  final String weatherCondition;

  Weather({required this.cityName, required this.temperature, required this.weatherCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final List<dynamic> weatherData = json['weather'];
    final String condition = weatherData.isNotEmpty ? weatherData[0]['main'] : 'Unknown';
      return Weather(
        cityName: json['name'],
        temperature: (json['main']['temp'] - 273.15),
        weatherCondition: condition,
      );
    }
}
