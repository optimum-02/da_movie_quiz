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
        title: const Text('Vos scores'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Hight score"),
            trailing: Text("$hightScore"),
          ),
          ListTile(
              title: const Text("Last score"), trailing: Text("$lastScore"))
        ],
      ),
    );
  }
}
