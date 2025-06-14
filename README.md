# Application Météo

Une application mobile développée avec Flutter pour afficher les données météorologiques en temps réel. L'application utilise l'API OpenWeather pour récupérer les données météo et Supabase pour la gestion de l'authentification des utilisateurs.

## Présentation du Projet

L'application Météo est conçue pour fournir aux utilisateurs des informations météorologiques précises et en temps réel pour leur localisation actuelle. Les principales fonctionnalités incluent :

- Affichage de la température actuelle.
- Affichage des conditions météorologiques principales.
- Connexion et inscription des utilisateurs via Supabase.
- Récupération automatique de la localisation de l'utilisateur pour afficher les données météo locales.

## Difficultés Rencontrées

Durant le développement de cette application, plusieurs défis ont été rencontrés :


1. **Intégration de l'API OpenWeather :**
   - L'intégration de l'API OpenWeather nécessite une bonne compréhension des appels API et de la gestion des réponses JSON. La gestion des erreurs et des cas où les données ne sont pas disponibles a également été un défi.

2. **Gestion des États dans Flutter :**
   - La gestion des états, en particulier pour les données asynchrones comme les données météo, a nécessité une planification minutieuse pour s'assurer que l'interface utilisateur reste réactive et à jour.

3. **Authentification avec Supabase :**
   - L'intégration de Supabase pour l'authentification a partiellement échoué dans le sans ou lorsqu'un utilisateur s'inscrit ses données ne sont pas intégré à la base de donnée mais ils sont enregistrés.

## Dépendances

Voici les principales dépendances utilisées dans ce projet :

- **Flutter SDK** : Le framework principal pour le développement de l'application.
- **Supabase** : Utilisé pour l'authentification des utilisateurs.
- **http** : Pour effectuer des requêtes HTTP à l'API OpenWeather.
- **geolocator** : Pour accéder aux fonctionnalités de géolocalisation de l'appareil.
- **geocoding** : Pour convertir les coordonnées géographiques en informations de lieu lisibles.
- **logging** : Pour la journalisation des événements et des erreurs.

Pour installer ces dépendances, ajoutez-les à votre fichier `pubspec.yaml` :

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^1.0.0
  http: ^0.13.4
  geolocator: ^9.0.2
  geocoding: ^2.0.4
  logging: ^1.0.2
```