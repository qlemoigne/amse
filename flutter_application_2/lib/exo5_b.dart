import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class ImagesTuilesViewWidget extends StatefulWidget {
  const ImagesTuilesViewWidget({super.key});

  @override
  State<ImagesTuilesViewWidget> createState() => _ImagesTuilesViewWidgetState();
}

class _ImageTile {
  String assetName;
  Alignment alignment;

  _ImageTile({required this.assetName, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.asset('assets/images/' + this.assetName),
          ),
        ),
      ),
    );
  }
}

class _ImagesTuilesViewWidgetState extends State<ImagesTuilesViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Images GridView'),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(4),
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 3,
          children: [
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(-1, -1))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(0, -1))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(1, -1))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(-1, 0))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(0, 0))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(1, 0))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(-1, 1))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(0, 1))
                    .croppedImageTile()),
            Padding(
                padding: EdgeInsets.all(0.5),
                child: _ImageTile(
                        assetName: "test2.jpg", alignment: Alignment(1, 1))
                    .croppedImageTile()),
          ],
        ));
  }
}
