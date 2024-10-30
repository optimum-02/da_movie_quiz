part of '../pages/game_page.dart';

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

        if (state.roundLoading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (state.currentQuiz != null) ...[
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
                style: OutlinedButton.styleFrom(
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
