part of '../pages/game_page.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous pouvez rejouer afin d'établir un nouveau record de score",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 24),
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
