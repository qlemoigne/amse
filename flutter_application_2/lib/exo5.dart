import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class TuilesViewWidget extends StatefulWidget {
  const TuilesViewWidget({super.key});

  @override
  State<TuilesViewWidget> createState() => _TuilesViewWidgetState();
}

class _TuilesViewWidgetState extends State<TuilesViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GridView'),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(4),
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 3,
          children: [
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.pink, child: Center(child: Text('Tuile 1')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.blue, child: Center(child: Text('Tuile 2')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.cyan, child: Center(child: Text('Tuile 3')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.orange,
                    child: Center(child: Text('Tuile 4')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.deepPurple,
                    child: Center(child: Text('Tuile 5')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.yellow,
                    child: Center(child: Text('Tuile 6')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.brown,
                    child: Center(child: Text('Tuile 7')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.purple,
                    child: Center(child: Text('Tuile 8')))),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                    color: Colors.red, child: Center(child: Text('Tuile 9')))),
          ],
        ));
  }
}
