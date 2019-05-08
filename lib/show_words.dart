import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert';

class ShowWord extends StatefulWidget {
  @override
  _ShowWordState createState() => _ShowWordState();
}

class _ShowWordState extends State<ShowWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/word.json'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            List<dynamic> fugaMap = jsonDecode(snapshot.data);
            List<Word> list = [];
            for (Map<String, dynamic> word in fugaMap) {
              list.add(Word.fromJson(word));
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                Word word = list[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(word.plan),
                      trailing: Icon(Icons.favorite_border),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Word {
  int _id;
  String _plan;

  Word.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _plan = json["plan"];
  }

  String get plan => _plan;

  int get id => _id;
}
