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
        leading: const Icon(Icons.games_rounded),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Da Movie Quiz'),
      ),
      body: BlocConsumer<GameBloc, GameState>(listener: (context, state) {
        if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.toString())),
          );
        } else if (state is GameOver) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScoresPage(
                hightScore: 200,
                lastScore: (state).finalScore,
              ),
            ),
          );
        }
      }, builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) {
                return switch (state) {
                  GameInitial() => const StartGameWidget(),
                  RoundLoading() => const CircularProgressIndicator(),
                  GameInProgress gameInProgress =>
                    GameInProgressWidget(gameInProgress),
                  GameOver() => const GameOverWidget(),
                  GameError gameError => GameErrorWidget(gameError: gameError),
                };
              },
            ),
          ),
        );
      }),
    );
  }
}

class StartGameWidget extends StatelessWidget {
  const StartGameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: 'Dans un délai de  ',
              children: [
                TextSpan(
                  text: '60 secondes',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const TextSpan(
                    text:
                        ' vous aurez à repondre à un nombre maximale de question.'),
              ],
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
              text: 'Pour chaque question repondez par  ',
              children: [
                TextSpan(
                  text: 'OUI / NON',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const TextSpan(
                    text: ' en cliquant sur le button correspondant'),
              ],
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(48)),
          onPressed: () => context.read<GameBloc>().add(GameStarted()),
          child: const Text('PLAY'),
        ),
      ],
    );
  }
}

class GameInProgressWidget extends StatelessWidget {
  const GameInProgressWidget(
    this.state, {
    super.key,
  });

  final GameInProgress state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.primaryContainer,
          alignment: Alignment.center,
          child: Text(
            'Temps restant: ${state.timeLeft}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // Text(
        //   'Score: ${state.score}',
        //   style: Theme.of(context).textTheme.titleLarge,
        // ),
        const SizedBox(height: 20),
        if (state.currentQuiz != null) ...[
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                'https://image.tmdb.org/t/p/w200${state.currentQuiz!.actor.profilePath}'),
          ),
          const SizedBox(height: 8),
          Text(
            state.currentQuiz!.actor.name,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${state.currentQuiz!.movie.posterPath}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const Divider()),
          // Text(
          //   state.currentQuiz!.movie.title,
          //   style: Theme.of(context).textTheme.labelMedium,
          // ),
          const SizedBox(height: 30),
          Text(
            "L'acteur a t il joué dans le film ci-dessus ?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: const Size(48, 48)),
                onPressed: () =>
                    context.read<GameBloc>().add(AnswerQuestion(true)),
                label: const Text('OUI'),
                icon: const Icon(Icons.check_circle_rounded),
              ),
              OutlinedButton.icon(
                label: const Text("NON"),
                icon: const Icon(Icons.cancel_rounded),
                style: ElevatedButton.styleFrom(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.primary,
                  // foregroundColor:
                  //     Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(48, 48),
                ),
                onPressed: () =>
                    context.read<GameBloc>().add(AnswerQuestion(false)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class GameErrorWidget extends StatelessWidget {
  const GameErrorWidget({
    super.key,
    required this.gameError,
  });

  final GameError gameError;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(gameError.failure.toMessage()),
        ElevatedButton(
          onPressed: () {
            context.read<GameBloc>().add(NewRoundLoaded());
          },
          child: const Text("Retry"),
        ),
      ],
    );
  }
}

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
            "Vous pouvez rejouer afin d'établir un nouveau record de score"),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(48)),
          onPressed: () {
            context.read<GameBloc>().add(GameStarted());
          },
          child: const Text("Play Again"),
        ),
      ],
    );
  }
}
