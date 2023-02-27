import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;
  double factor;

  Tile({required this.imageURL, required this.alignment, required this.factor});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: factor,
            heightFactor: factor,
            child: Image.asset(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class DisplayTileWidget extends StatefulWidget {
  const DisplayTileWidget({super.key});

  @override
  State<DisplayTileWidget> createState() => _DisplayTileWidgetState();
}

class _DisplayTileWidgetState extends State<DisplayTileWidget> {
  double _translateX = 0.0;
  double _translateY = 0.0;
  double _factor = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display a Tile as a Cropped Image'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  child: new Tile(
                          imageURL: 'assets/images/test1.jpg',
                          alignment:
                              Alignment(_translateX / 100, _translateY / 100),
                          factor: _factor / 100)
                      .croppedImageTile(),
                  onTap: () {
                    print("tapped on tile");
                  },
                ))),
        Container(
            height: 200,
            child: Image.asset('assets/images/test1.jpg', fit: BoxFit.cover)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const Text(
              "Translate X : ",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
                child: Slider(
              value: _translateX,
              min: -100,
              max: 100,
              divisions: 200,
              label: _translateX.round().toString() + " %",
              onChanged: (double value) {
                setState(() {
                  _translateX = value;
                });
              },
            )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const Text(
              "Translate Y : ",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
                child: Slider(
              value: _translateY,
              min: -100,
              max: 100,
              divisions: 200,
              label: _translateY.round().toString() + " %",
              onChanged: (double value) {
                setState(() {
                  _translateY = value;
                });
              },
            ))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const Text(
              "Size : ",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
                child: Slider(
              value: _factor,
              min: 0,
              max: 100,
              divisions: 100,
              label: _factor.round().toString() + " %",
              onChanged: (double value) {
                setState(() {
                  _factor = value;
                });
              },
            ))
          ],
        ),
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
