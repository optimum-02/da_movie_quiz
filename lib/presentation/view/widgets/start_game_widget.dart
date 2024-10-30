part of '../pages/game_page.dart';

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
