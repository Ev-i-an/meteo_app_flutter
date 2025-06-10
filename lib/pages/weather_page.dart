import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/models/weather_models.dart';

final String apiKey = 'votre_clé_api_ici'; // Assurez-vous de définir votre clé API

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;
  final _log = Logger('WeatherPage');

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      _log.severe('Failed to fetch weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Chargement de la ville..."),
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
