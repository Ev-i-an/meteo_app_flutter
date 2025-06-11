// Importation des bibliothèques nécessaires
import 'dart:convert'; // Pour utiliser jsonDecode et manipuler les données JSON
import 'package:http/http.dart' as http; // Pour effectuer des requêtes HTTP
import 'package:geolocator/geolocator.dart'; // Pour accéder aux fonctionnalités de géolocalisation
import 'package:geocoding/geocoding.dart'; // Pour convertir les coordonnées géographiques en informations de lieu
import '../models/weather_models.dart'; // Importation du modèle de données météo


class WeatherService {
  // URL de base pour l'API OpenWeatherMap
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey; // Clé API pour accéder au service de météo

  // Constructeur de la classe WeatherService
  WeatherService(this.apiKey);

  // Méthode pour récupérer les données météo d'une ville donnée
  Future<Weather> getWeather(String cityName) async {
    // Effectue une requête GET à l'API OpenWeatherMap avec le nom de la ville et la clé API
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    // Vérifie si la requête a réussi (code de statut 200)
    if (response.statusCode == 200) {
      // Décode la réponse JSON et crée un objet Weather à partir des données
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // Lance une exception si la requête échoue
      throw Exception('Failed to load weather data');
    }
  }

  // Méthode pour obtenir le nom de la ville actuelle en utilisant la géolocalisation
  Future<String> getCurrentCity() async {
    // Vérifie les permissions de géolocalisation
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Demande la permission si elle est refusée
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Retourne une chaîne vide si la permission est toujours refusée
        return "";
      }
    }

    // Obtient la position actuelle de l'utilisateur avec une haute précision
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Convertit les coordonnées géographiques en informations de lieu
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extrait le nom de la localité (ville) à partir des informations de lieu
    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

    // Retourne le nom de la ville ou une chaîne vide si le nom de la ville est null
    return city ?? "";
  }
}
