import 'dart:convert'; // Pour jsonDecode
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart'; // Pour la géolocalisation
import 'package:geocoding/geocoding.dart'; // Pour Placemark et placemarkFromCoordinates
import '../models/weather_models.dart';

class WeatherService {
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return ""; // Retourner une valeur par défaut si la permission est refusée
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

    return city ?? "";
  }
}
