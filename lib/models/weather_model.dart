class Weather {
  String cityName;
  double temperature;
  double feelsLike;
  int humidity;
  double windSpeed;
  String mainCondition;
  String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.mainCondition,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity']),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
