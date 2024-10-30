import 'package:flutter/material.dart';

class ScoresPage extends StatelessWidget {
  const ScoresPage(
      {super.key, required this.hightScore, required this.lastScore});
  final int hightScore;
  final int lastScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Vos scores'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Your score"),
            trailing: CircleAvatar(
              radius: 20,
              child: Text(
                "$lastScore",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ListTile(
            title: const Text("Hight score"),
            trailing: CircleAvatar(
              radius: 20,
              child: Text(
                "$hightScore",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
