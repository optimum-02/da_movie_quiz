part of '../pages/game_page.dart';

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
        Text(
          gameError.failure.toMessage(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.error),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: () {
            context.read<GameBloc>().add(NewRoundLoaded());
          },
          label: const Text("Retry"),
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }
}
