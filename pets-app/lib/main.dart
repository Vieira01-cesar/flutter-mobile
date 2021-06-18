import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pets_app/api.dart';
import 'package:pets_app/pet.dart';
import 'package:pets_app/tela2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  var pets = new List<Pet>();
  int imgIndex = 0;

  void _prevImg() {
    setState(() {
      imgIndex = imgIndex > 0 ? imgIndex - 1 : 0;
    });
  }

  void _nextImg() {
    setState(() {
      imgIndex = imgIndex < pets.length - 1 ? imgIndex + 1 : imgIndex;
    });
  }

  _getPets() {
    API.getPets().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        pets = list.map((model) => Pet.fromJson(model)).toList();
      });
    });
  }

  _BuildListViewState() {
    _getPets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Pets"),
        ),
        body: listaPets());
  }

  listPetsName() {
    return ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pets[index].name),
          );
        });
  }

  listaPets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            pets[imgIndex].name + " | " + pets[imgIndex].price.toString(),
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Center(
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                      image: NetworkImage(pets[imgIndex].picture),
                      fit: BoxFit.cover)),
              height: 400.0,
              width: 300.0,
            )
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Prev'),
              onPressed: _prevImg,
              elevation: 5.0,
              color: Colors.green,
            ),
            SizedBox(width: 10.0),
            RaisedButton(
              child: Text('Next'),
              onPressed: _nextImg,
              elevation: 5.0,
              color: Colors.blue,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Não gosta de comer: " +
                pets[imgIndex].foods['dislikes'].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Text('   '),
        FlatButton(
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Screen2()));
          },
          child: Text('Lista de Animais'),
        ),
      ],
    );
  }
}
