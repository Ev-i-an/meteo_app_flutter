// Définition de la classe Weather qui représente les données météorologiques
class Weather {
  // Déclaration des propriétés de la classe
  final String cityName; // Nom de la ville
  final double temperature; // Température actuelle
  final String mainCondition; // Condition météo principale (par exemple, "Clear", "Rain", etc.)

  // Constructeur de la classe Weather
  // Utilisation de paramètres nommés obligatoires avec `required`
  Weather({
    required this.cityName, // Le nom de la ville est requis
    required this.temperature, // La température est requise
    required this.mainCondition, // La condition météo principale est requise
  });

  // Méthode de fabrication (factory) pour créer une instance de Weather à partir d'un JSON
  // Les méthodes factory sont utilisées pour des constructions d'objets plus complexes
  factory Weather.fromJson(Map<String, dynamic> json) {
    // Retourne une nouvelle instance de Weather en extrayant les données du JSON
    return Weather(
      cityName: json['name'], // Extrait le nom de la ville du JSON
      temperature: json['main']['temp'].toDouble(), // Extrait la température et la convertit en double
      mainCondition: json['weather'][0]['main'], // Extrait la condition météo principale
    );
  }
}
