import 'package:flutter/material.dart';
import 'package:meteo_app/auth/auth_service.dart';
import 'package:meteo_app/pages/register_page.dart';
import 'package:meteo_app/pages/weather_page.dart'; // Importation de WeatherPage
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService(Supabase.instance.client);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Tentative de connexion avec l'email et le mot de passe
      await authService.signInWithEmailPassword(email, password);

      // Redirection vers WeatherPage après une connexion réussie
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WeatherPage()),
        );
      }
    } catch (e) {
      // Affichage d'un message d'erreur si la connexion échoue
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: login,
            child: const Text("Connexion"),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            ),
            child: const Center(child: Text("Vous n'avez pas de compte ? Inscrivez-vous")),
          ),
        ],
      ),
    );
  }
}
