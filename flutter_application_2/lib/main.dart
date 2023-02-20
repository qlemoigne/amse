import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/tile.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  List<int> positions = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  Alignment gapLocation =
      Alignment(Random().nextInt(3) - 1, Random().nextInt(3) - 1);

  List<Tile> tileList = [
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(-1, -1),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(0, -1),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(1, -1),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(-1, 0),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(0, 0),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(1, 0),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(-1, 1),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(0, 1),
    ),
    Tile(
      imageURL:
          'https://fastly.picsum.photos/id/617/512/512.jpg?hmac=n2AkUwuvm_IQ1lMZzltY4bfFZrW7HU_JYx6cSaQvhbQ',
      alignment: Alignment(1, 1),
    ),
  ];

  List<Alignment> orderToAlignment = [
    Alignment(-1, -1),
    Alignment(0, -1),
    Alignment(1, -1),
    Alignment(-1, 0),
    Alignment(0, 0),
    Alignment(1, 0),
    Alignment(-1, 1),
    Alignment(0, 1),
    Alignment(1, 1),
  ];

  List<Widget> buildTilesList() {
    List<Widget> l = [];
    var gapOrder = 0;
    var gapVisibleLocation = Alignment(0, 0);
    // recherche l'order du gap
    for (var position in positions) {
      if (orderToAlignment[position].x == gapLocation.x &&
          orderToAlignment[position].y == gapLocation.y) {
        // c'est le gap
        gapVisibleLocation = orderToAlignment[position];
        break;
      }

      gapOrder++;
    }

    var order = 0;

    for (var position in positions) {
      l.add(createTileWidgetFrom(position, orderToAlignment[order],
          tileList[position], positions, gapVisibleLocation, gapLocation));

      order++;
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // a move todo
    positions.shuffle();

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(4),
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 3,
          children: buildTilesList(),
        ));
  }
}
