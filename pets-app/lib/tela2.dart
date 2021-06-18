import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final List<String> names = <String>[
    'Meowsy',
    'Barky',
    'Purrpaws',
    'Tom',
    'Spike',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Todos Animais'),
            backgroundColor: Colors.blueAccent),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: EdgeInsets.all(2),
                child: Center(
                    child: Text(
                  '${names[index]}',
                  style: TextStyle(fontSize: 18),
                )),
              );
            }));
  }
}
