import 'package:da_movie_quiz/core/dependencie_injection.dart';
import 'package:da_movie_quiz/presentation/state/game_bloc/game_bloc.dart';
import 'package:da_movie_quiz/presentation/view/pages/scores_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(
        getRandomQuiz: di.get(),
      ),
      child: const PlayScreenContent(),
    );
  }
}

class PlayScreenContent extends StatelessWidget {
  const PlayScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Da Movie Quiz'),
      ),
      body: BlocConsumer<GameBloc, GameState>(listener: (context, state) {
        if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.toString())),
          );
        } else if (state is GameOver) {
          _showGameOverDialog(context, state.finalScore);
        }
      }, builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) {
                return switch (state) {
                  GameInitial() => ElevatedButton(
                      onPressed: () =>
                          context.read<GameBloc>().add(GameStarted()),
                      child: const Text('PLAY'),
                    ),
                  RoundLoading() => const CircularProgressIndicator(),
                  GameInProgress() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Temps restant: ${state.timeLeft}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Score: ${state.score}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        if (state.currentQuiz != null) ...[
                          CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://image.tmdb.org/t/p/w200${state.currentQuiz!.actor.profilePath}'),
                              child: Text(state.currentQuiz!.actor.name[0])),
                          const SizedBox(height: 10),
                          Text(
                            state.currentQuiz!.actor.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 20),
                          Image.network(
                            'https://image.tmdb.org/t/p/w300${state.currentQuiz!.movie.posterPath}',
                            height: 200,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.currentQuiz!.movie.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => context
                                    .read<GameBloc>()
                                    .add(AnswerQuestion(true)),
                                child: const Text('OUI'),
                              ),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<GameBloc>()
                                    .add(AnswerQuestion(false)),
                                child: const Text('NON'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  GameOver() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Game Over! Your score: ${state.finalScore}"),
                        ElevatedButton(
                          onPressed: () {
                            context.read<GameBloc>().add(GameStarted());
                          },
                          child: const Text("Play Again"),
                        ),
                      ],
                    ),
                  GameError() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Oups ! Une erreur est intervenue"),
                        ElevatedButton(
                          onPressed: () {
                            context.read<GameBloc>().add(NewRoundLoaded());
                          },
                          child: const Text("Ressayer"),
                        ),
                      ],
                    ),
                };
              },
            ),
          ),
        );
      }),
    );
  }

  void _showGameOverDialog(BuildContext pageContext, int score) {
    showDialog(
      context: pageContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Votre score: $score'),
          actions: <Widget>[
            TextButton(
              child: const Text('Rejouer'),
              onPressed: () {
                pageContext.read<GameBloc>().add(GameStarted());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Voir les scores'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScoresPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
