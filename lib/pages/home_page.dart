import 'dart:io';

import 'package:bandsname/models/Band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Queen", votes: 3),
    Band(id: "2", name: "Metallica", votes: 4),
    Band(id: "3", name: "Green Day", votes: 2),
    Band(id: "4", name: "Sonata Arctica", votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Bandas",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _bandList(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addBand();
          }),
    );
  }

  Widget _bandList(Band band) {
    return Dismissible(
      key: Key(band.id),
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(direction);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: () {},
      ),
    );
  }

  addBand() {
    final TextEditingController textController = new TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Crear Banda"),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text("Agregar"),
                  color: Colors.blue,
                  elevation: 5,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 0) {
      bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
