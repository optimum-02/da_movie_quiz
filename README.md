# DaMovieQuiz 🎬

DaMovieQuiz est une application mobile Flutter qui teste vos connaissances cinématographiques ! Vous aurez quelques secondes pour deviner si l'acteur proposé a joué dans le film affiché. Attention, une erreur mettra fin à la partie, alors restez concentré !

---

## Architecture du projet

L'architecture est basée sur le modèle **Clean Architecture** pour assurer une bonne séparation des responsabilités, la testabilité et la maintenabilité du code. Voici un aperçu des différentes couches :
```bash
└───lib
    ├───core
    ├───data
    │   ├───datasource
    │   ├───dtos
    │   └───repository_impl
    ├───domain
    │   ├───entities
    │   ├───repositories
    │   └───uses_cases
    └───presentation
        ├───state
        │   └───game_bloc
        └───view
            ├───pages
            └───widgets
```

### 1. **Domaine** 
   - **Entities** : Définition des entités de base du jeu, comme `MovieActor`, `Movie`, et `Quiz`.
   - **Interfaces** : Interface de `MovieRepository`, permettant d'abstraire les appels API et de rendre le code indépendant de la source de données.
   - **UsesCases** : Utilisation des modèles et des règles métier pour organiser les interactions entre les entités.

### 2. **Données** 
   - **Sources de données** : Accès aux données cinéma via l’API The Movie Database (TMDB) en utilisant des requêtes HTTP et sauvegarde locale des scores
   - **Modele DTO** : Accès aux données cinéma via l’API The Movie Database (TMDB) en utilisant des requêtes HTTP.
   - **Gestion des erreurs** : Une fonction utilitaire gère les erreurs d'appel API pour gérer proprement les erreurs serveur, les exceptions de connexion, et autres erreurs non prévues.
   - **Implementer les interfaces du repository du domaine** : Une fonction utilitaire gère les erreurs d'appel API pour gérer proprement les erreurs serveur, les exceptions de connexion, et autres erreurs non prévues.

### 3. **Presentation**
   - **State** : Gestion des états de l'application via le package `flutter_bloc`, facilitant l'interaction entre les événements (`QuizEvent`) et les états (`QuizState`).
   - **View** : Widgets Flutter pour l’interface utilisateur, y compris l’affichage des questions, des réponses, des scores, et de la fin de partie.


## Installation et Exécution

1. **Cloner le projet** :
   ```bash
   git clone https://github.com/optimum-02/da_movie_quiz.git
   cd da_movie_quiz
   ```

2. **Installer les dépendances** :
   Assurez-vous d’avoir Flutter installé, puis exécutez :
   ```bash
   dart pub get
   ```

3. **Configurer l’API Key** :
   Assurez-vous d’avoir une clé API pour The Movie Database (TMDB) et ajoutez-la dans le fichier `env.json`. Un exemple du contenu du fichier se trouve dans `env.example.json`

4. **Exécuter l’application** :
   ```bash
   flutter run --dart-define-from-file=env.json
   ```
