import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Générateur de mots', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _mots = <WordPair>[];
  final _motsFont = const TextStyle(fontSize: 18.0);
  final _motsSauvegardes = <WordPair>{};

  Widget _buildListeMots() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _mots.length) {
          _mots.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildMot(_mots[index]);
      },
    );
  }

  Widget _buildMot(WordPair pair) {
    final estDansLaListe = _motsSauvegardes.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _motsFont,
      ),
      trailing: Icon(
        // NEW from here...
        estDansLaListe ? Icons.favorite : Icons.favorite_border,
        color: estDansLaListe ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (estDansLaListe) {
            _motsSauvegardes.remove(pair);
          } else {
            _motsSauvegardes.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générateur de mots'),
      ),
      body: _buildListeMots(),
    );
  }
}
