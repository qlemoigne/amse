import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

/*FittedBox(
            fit: BoxFit.fill,
            child: ClipRect(
              child: Container(
                child: Align(
                    alignment: this.alignment,
                    widthFactor: 0.3,
                    heightFactor: 0.3,
                    child: Container(color: Colors.orange)),
              ),
            ),
          )*/

int alignmentToIndex(Alignment alignment) {
  if (alignment.y == -1) {
    return alignment.x.toInt() + 1;
  }

  if (alignment.y == 0) {
    return alignment.x.toInt() + 1 + 3;
  }

  if (alignment.y == 1) {
    return alignment.x.toInt() + 1 + 3 + 3;
  }

  return 0;
}

/**
 * 
 * 
 * 
 */
Widget createTileWidgetFrom(
    int position,
    Alignment visibleLocation,
    Tile tile,
    List<int> positions,
    Alignment gapVisibleLocation,
    Alignment gapBaseLocation) {
  // si c'est le gap
  if (tile.alignment.x == gapBaseLocation.x &&
      tile.alignment.y == gapBaseLocation.y) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
              alignment: tile.alignment,
              widthFactor: 0.3,
              heightFactor: 0.3,
              child: Container(color: Colors.orange)),
        ),
      ),
    );
  }

  return InkWell(
    child: tile.croppedImageTile(),
    onTap: () {
      /*if (visibleLocation.x == gapVisibleLocation.x) {
        if ((gapVisibleLocation.y - visibleLocation.y).abs() <= 1) {
          print("OK");
          return;
        }
      }

      if (visibleLocation.y == gapVisibleLocation.y) {
        if ((gapVisibleLocation.x - visibleLocation.x).abs() <= 1) {
          print("OK");
          return;
        }
      }*/
      print("PAS OK");
    },
  );
}
