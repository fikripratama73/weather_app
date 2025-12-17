import 'package:weather_app/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  bool isLoading = false;

  Future<void> _getWeather(String city) async {
    setState(() => isLoading = true);
    try {
      final service = WeatherService(
        apiKey: "994f7d24db0537a54f5bcf6c16c4ff88",
      );
      final weather = await service.fetchWeather(city);
      setState(() => _weather = weather);
    } catch (e) {
      setState(() => _weather = null);
    } finally {
      setState(() => isLoading = false);
    }
  }

  String getWeatherAnimation() {
    switch (_weather?.mainCondition.toLowerCase()) {
      case "clouds":
        return "assets/icons/cloudy.json";
      case "rain":
        return "assets/icons/rainy.json";
      case "snow":
        return "assets/icons/snowy.json";
      case "thunderstorm":
        return "assets/icons/storm.json";
      case "sunny":
        return "assets/icons/sunny.json";
      case "fog":
      case "mist":
      case "haze":
        return "assets/icons/foggy.json";
      default:
        return "assets/icons/sunny.json";
    }
  }

  LinearGradient getBackgroundGradient() {
    switch (_weather?.mainCondition.toLowerCase()) {
      case "clear":
        return const LinearGradient(
          colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "clouds":
        return LinearGradient(
          colors: [Colors.blueGrey.shade300, Colors.blueGrey.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "rain":
        return LinearGradient(
          colors: [Colors.indigo.shade800, Colors.blueGrey.shade600],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "thunderstorm":
        return const LinearGradient(
          colors: [Color(0xFF373B44), Color(0xFF4286f4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "snow":
        return const LinearGradient(
          colors: [Colors.white, Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "mist":
      case "fog":
      case "haze":
        return LinearGradient(
          colors: [Colors.grey.shade400, Colors.grey.shade200],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Colors.grey, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(gradient: getBackgroundGradient()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // search bar
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _getWeather(value);
                        }
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 26,
                        ),
                        hintText: "Search Your Location...",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 12),
                      ),
                    ),
                  ),

                  SizedBox(height: 60),
                  Text(
                    _weather?.cityName ?? "--",
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      height: 1.2,
                      wordSpacing: 0.25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 20),
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Lottie.asset(getWeatherAnimation()),
                  ),

                  SizedBox(height: 15),
                  Text(
                    "${_weather?.temperature.round() ?? "--"}°C",
                    style: GoogleFonts.poppins(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),

                  SizedBox(height: 5),
                  Text(
                    _weather?.mainCondition ?? "--",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoCard(
                        icon: Icons.water_drop,
                        iconColor: Colors.blue,
                        textValue: "${_weather?.humidity ?? '--'}%",
                        textLabel: "Humidity",
                      ),
                      InfoCard(
                        icon: Icons.air,
                        iconColor: Colors.green,
                        textValue:
                            "${_weather?.windSpeed.toInt() ?? '--'} Km/h",
                        textLabel: "Wind",
                      ),
                      InfoCard(
                        icon: Icons.thermostat,
                        iconColor: Colors.red,
                        textValue: "${_weather?.feelsLike.toInt() ?? '--'}°C",
                        textLabel: "Feels Like",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
