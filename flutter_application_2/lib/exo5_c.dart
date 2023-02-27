import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class ResizableImagesTuilesViewWidget extends StatefulWidget {
  const ResizableImagesTuilesViewWidget({super.key});

  @override
  State<ResizableImagesTuilesViewWidget> createState() =>
      _ResizableImagesTuilesViewWidgetState();
}

class _ImageTile {
  String assetName;
  Alignment alignment;
  int lineSize;

  _ImageTile(
      {required this.assetName,
      required this.alignment,
      required this.lineSize});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 1 / lineSize,
            heightFactor: 1 / lineSize,
            child: Image.asset('assets/images/' + this.assetName),
          ),
        ),
      ),
    );
  }
}

class _ResizableImagesTuilesViewWidgetState
    extends State<ResizableImagesTuilesViewWidget> {
  int _lineSize = 3;

  List<Widget> buildTilesList() {
    List<Widget> l = [];

    for (var y = 1; y <= _lineSize; y++) {
      for (var x = 1; x <= _lineSize; x++) {
        double rx = (((x - 1) * (2)) / (_lineSize - 1)) - 1;
        double ry = (((y - 1) * (2)) / (_lineSize - 1)) - 1;

        l.add(Padding(
            padding: EdgeInsets.all(0.5),
            child: _ImageTile(
                    assetName: "test2.jpg",
                    alignment: Alignment(rx, ry),
                    lineSize: _lineSize)
                .croppedImageTile()));
      }
    }

    /*Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(0, -1))
                    .croppedImageTile()),*/
    /*var gapOrder = 0;
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
    }*/

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Images GridView'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(4),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              crossAxisCount: _lineSize,
              children: buildTilesList(),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                const Text(
                  "Taille Grille : ",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Slider(
                  value: _lineSize.toDouble(),
                  min: 2,
                  max: 8,
                  divisions: 7,
                  label: _lineSize.toString() + " x " + _lineSize.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _lineSize = value.toInt();
                    });
                  },
                )),
              ],
            ),
          ],
        ));
  }
}
