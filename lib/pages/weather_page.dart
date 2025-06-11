// Importation des bibliothèques et packages nécessaires
import 'package:flutter/material.dart'; // Pour créer des interfaces utilisateur avec Flutter
import 'package:logging/logging.dart'; // Pour la journalisation des erreurs et des événements
import 'package:meteo_app/services/weather_service.dart'; // Service pour récupérer les données météo
import 'package:meteo_app/models/weather_models.dart'; // Modèle de données pour les informations météo

// Clé API pour accéder au service de météo
final String apiKey = 'API_KEY'; // Remplacez par votre clé API réelle

// Définition de la classe WeatherPage qui étend StatefulWidget
// StatefulWidget est utilisé pour les widgets qui doivent gérer un état interne changeant
class WeatherPage extends StatefulWidget {
  // Constructeur de la classe WeatherPage
  const WeatherPage({super.key});

  // Méthode createState qui crée l'état associé à ce widget
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

// Définition de la classe _WeatherPageState qui gère l'état de WeatherPage
class _WeatherPageState extends State<WeatherPage> {
  // Création d'une instance de WeatherService pour récupérer les données météo
  final _weatherService = WeatherService(apiKey);
  // Variable pour stocker les données météo actuelles
  Weather? _weather;
  // Initialisation du logger pour la journalisation
  final _log = Logger('WeatherPage');

  // Méthode asynchrone pour récupérer les données météo
  Future<void> _fetchWeather() async {
    try {
      // Récupère le nom de la ville actuelle
      String cityName = await _weatherService.getCurrentCity();
      // Récupère les données météo pour la ville actuelle
      final weather = await _weatherService.getWeather(cityName);
      // Met à jour l'état avec les nouvelles données météo
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // Journalise une erreur si la récupération des données échoue
      _log.severe('Failed to fetch weather: $e');
    }
  }

  // Méthode initState appelée une fois que le widget est inséré dans l'arbre des widgets
  @override
  void initState() {
    super.initState(); // Appelle la méthode initState de la classe parente
    _fetchWeather(); // Appelle la méthode pour récupérer les données météo
  }

  // Méthode build qui décrit comment le widget doit être construit
  @override
  Widget build(BuildContext context) {
    // Retourne un Scaffold, qui fournit une structure de base pour l'interface utilisateur
    return Scaffold(
      // Centre le contenu de la page
      body: Center(
        child: Column(
          // Centre les enfants verticalement
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affiche le nom de la ville ou un message de chargement
            Text(_weather?.cityName ?? "Chargement de la ville..."),
            // Affiche la température ou un message de chargement
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
