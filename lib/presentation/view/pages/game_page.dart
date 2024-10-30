import 'package:da_movie_quiz/core/dependencie_injection.dart';
import 'package:da_movie_quiz/presentation/state/game_bloc/game_bloc.dart';
import 'package:da_movie_quiz/presentation/view/pages/scores_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widgets/game_error_widget.dart';
part '../widgets/game_in_progress_widget.dart';
part '../widgets/game_over_widget.dart';
part '../widgets/start_game_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<GameBloc>(),
      child: const GamePageContent(),
    );
  }
}

class GamePageContent extends StatelessWidget {
  const GamePageContent({super.key});

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
        if (state is GameOver) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScoresPage(
                hightScore: state.hightScore,
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
