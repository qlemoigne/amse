import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

import 'package:flutter_application_2/exo6.dart';

class TaquinWidget extends StatefulWidget {
  const TaquinWidget({super.key});

  @override
  State<TaquinWidget> createState() => _TaquinWidgetState();
}

class _ImageTile {
  String assetName;
  Alignment alignment;
  int lineSize;

  // position x, y originale
  int originalX;
  int originalY;

  // indique s'il s'agit de la tuile blanche
  bool white;

  _ImageTile(
      {required this.assetName,
      required this.alignment,
      required this.lineSize,
      required this.originalX,
      required this.originalY,
      required this.white});

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

class TileCoord {
  // col
  int x;

  // row
  int y;

  TileCoord({required this.x, required this.y});

  int getCol() {
    return x;
  }

  int getRow() {
    return y;
  }
}

class _TaquinWidgetState extends State<TaquinWidget> {
  int _lineSize = 3;

  // indique si la partie est en cours
  bool _running = false;

  List<_ImageTile> tiles = [];
  List<int> positions = [];

  _TaquinWidgetState() {
    generateTileList();
  }

  void moveTile(int relx, int rely) {
    if (relx != 0 && rely != 0) {
      print("Mouvement invalide. seule +1, -1, +1, -1");
      return;
    }

    if (relx.abs() != 1 && rely.abs() != 1) {
      print("Mouvement invalide. seule +1, -1, +1, -1");
      return;
    }

    // Format tableau tiles :
    int whiteIndex = getWhiteTileIndex();

    TileCoord whiteCoords = getCoordsFromIndex(whiteIndex);

    if ((whiteCoords.x == 1 && relx == -1) ||
        (whiteCoords.x == _lineSize && relx == 1) ||
        (whiteCoords.y == 1 && rely == -1) ||
        (whiteCoords.y == _lineSize && rely == 1)) {
      print("Impossible de sortir de la map");
      return;
    }

    // Mouvement autorisé
    TileCoord destCoord = whiteCoords;
    destCoord.x += relx;
    destCoord.y += rely;

    int destIndex = getIndexFromCoord(destCoord);

    // On inverse les deux
    setState(() {
      _ImageTile temp = tiles[destIndex];
      tiles[destIndex] = tiles[whiteIndex];
      tiles[whiteIndex] = temp;

      print("invertion faite de : " +
          whiteIndex.toString() +
          " vers " +
          destIndex.toString());
    });
  }

/**
 * Renvoit l'index dans le tableau de la tile blanche
 */
  int getWhiteTileIndex() {
    int index = 0;

    while (index < tiles.length && tiles[index].white == false) {
      index++;
    }
    return index;
  }

  void startGame() {
    if (_running) {
      return;
    }

    _running = true;

    print("starting game");
    generateTileList();

    int blankIndex = Random().nextInt(tiles.length);

    tiles[blankIndex].white = true;

    print("Tile blanche : x = " +
        tiles[blankIndex].originalX.toString() +
        " y = " +
        tiles[blankIndex].originalY.toString());

    for (int i = 0; i < 500; i++) {
      if (random.nextBool()) {
        moveTile(random.nextBool() ? -1 : 1, 0);
      } else {
        moveTile(0, random.nextBool() ? -1 : 1);
      }
    }

    setState(() {});
    //
    //moveTile(-1, 0);
    //moveTile(-1, 0);
    //moveTile(1, 0);
    //moveTile(1, 0);
    //positions.shuffle();

    // definir blank id
  }

  int getIndexFromCoord(TileCoord coord) {
    // 0 (1, 1), 1 (2, 1)
    return coord.x + _lineSize * (coord.y - 1) - 1;
  }

  void checkVictory() {
    int index = 0;

    bool won = true;
    for (var y = 1; y <= _lineSize; y++) {
      for (var x = 1; x <= _lineSize; x++) {
        if (tiles[index].originalX != x || tiles[index].originalY != y) {
          won = false;
          break;
        }

        index += 1;
      }
    }

    if (won) {
      print("VICTOIRE !!!!!");
    }
  }

  TileCoord getCoordsFromIndex(int index) {
    int line = 1;

    int r = index;

    while (r > _lineSize - 1) {
      r -= _lineSize;
      line++;
    }

    int col = (index % _lineSize) + 1;

    /*print("LS= " +
        _lineSize.toString() +
        "Index : " +
        index.toString() +
        " Ligne (y): " +
        line.toString() +
        " Col (x): " +
        col.toString());
*/

    return TileCoord(x: col, y: line);
  }

  List<Widget> buildTilesWidgetList() {
    List<Widget> l = [];

    int index = 0;

    TileCoord whiteCoord = getCoordsFromIndex(getWhiteTileIndex());

    for (_ImageTile tile in tiles) {
      if (tile.white) {
        l.add(Padding(
            padding: EdgeInsets.all(0.5),
            child: Container(
              color: Colors.white,
            )));
      } else {
        // pas white voir si clic action

        TileCoord tileCoord = getCoordsFromIndex(index);

        int relx = whiteCoord.x - tileCoord.x;
        int rely = whiteCoord.y - tileCoord.y;

        if (!_running ||
            relx != 0 && rely != 0 ||
            (relx.abs() != 1 && rely.abs() != 1)) {
          l.add(Padding(
              padding: EdgeInsets.all(0.5), child: tile.croppedImageTile()));
        } else {
          l.add(Padding(
              padding: EdgeInsets.all(0.5),
              child: InkWell(
                  child: tile.croppedImageTile(),
                  onTap: () {
                    moveTile(-relx, -rely);
                    checkVictory();
                  })));
        }
      }

      index++;
    }

    return l;
  }

  void generateTileList() {
    tiles.clear();

    for (var y = 1; y <= _lineSize; y++) {
      for (var x = 1; x <= _lineSize; x++) {
        int index = getIndexFromCoord(TileCoord(x: x, y: y));
        print("=> " +
            x.toString() +
            " , " +
            y.toString() +
            " ===> " +
            index.toString());

        double rx = (((x - 1) * (2)) / (_lineSize - 1)) - 1;
        double ry = (((y - 1) * (2)) / (_lineSize - 1)) - 1;

        tiles.add(_ImageTile(
            assetName: "test2.jpg",
            alignment: Alignment(rx, ry),
            originalX: x,
            originalY: y,
            lineSize: _lineSize,
            white: false));
      }
    }
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
              children: buildTilesWidgetList(),
            )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: _running
              ? null
              : () {
                  startGame();
                },
          tooltip: 'Lancer la partie',
          child: const Icon(Icons.play_arrow),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.blue,
            child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  IconButton(
                    tooltip: '-1',
                    icon: const Icon(Icons.remove),
                    onPressed: (_lineSize <= 2 || _running)
                        ? null
                        : () {
                            setState(() {
                              _lineSize -= 1;
                              generateTileList();
                            });
                          },
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: '+1',
                    icon: const Icon(Icons.add),
                    onPressed: (_lineSize >= 8 || _running)
                        ? null
                        : () {
                            setState(() {
                              _lineSize += 1;
                              generateTileList();
                            });
                          },
                  ),
                  const Spacer(),
                ],
              ),
            )));
  }
}
