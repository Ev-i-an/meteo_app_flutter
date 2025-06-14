// Importation des bibliothèques nécessaires
import 'package:flutter/material.dart'; // Importation du package Flutter pour créer des applications
import 'package:meteo_app/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Fonction principale, point d'entrée de l'application
void main() async {

  await Supabase.initialize(
    anonKey: "API_KEY",
    url:"URL_KEY",
  );
  // Exécute l'application Flutter avec MyApp comme widget racine
  runApp(const MyApp());
}

// Définition de la classe MyApp qui étend StatelessWidget
// StatelessWidget est utilisé pour les widgets qui n'ont pas besoin de gérer un état interne
class MyApp extends StatelessWidget {
  // Constructeur de la classe MyApp
  const MyApp({super.key});

  // Méthode build qui décrit comment le widget doit être construit
  @override
  Widget build(BuildContext context) {
    // Retourne un widget MaterialApp, qui est la base de toute application Flutter
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Désactive le banner de debug en haut à droite
      home: LoginPage(), // Définit la page d'accueil de l'application comme étant WeatherPage
    );
  }
}

