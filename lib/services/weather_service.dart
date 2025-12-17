import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse(
      "$baseUrl?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric",
    );

    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        return Weather.fromJson(jsonData);
      } else {
        throw Exception("Gagal ambil data ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
