import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_2/exo6.dart';
import 'package:confetti/confetti.dart';

class TaquinWidget extends StatefulWidget {
  const TaquinWidget({super.key});

  @override
  State<TaquinWidget> createState() => _TaquinWidgetState();
}

class _ImageTile {
  // nom fichier
  String assetName;

  // alignement
  Alignment alignment;

  // nb elem par ligne
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

/*
* Coordonnées du tile
*/
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

  // liste tile
  List<_ImageTile> tiles = [];

  // historique des mouvements
  List<TileCoord> movesHistory = [];

  // nombre de mouvements
  int _stepCount = 0;

  // indique si la personne à win
  bool _hasWon = false;

  late ConfettiController _controllerCenter;

  // difficulté choisie
  int _selectedDifficulty = 0;

  _TaquinWidgetState() {
    generateTileList();
  }

  @override
  void initState() {
    super.initState();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }

  void computeMinimumStepCount() {
    List<_ImageTile> currentState = tiles;
  }

  void moveTile(int relx, int rely, bool preparationState, bool historyMove) {
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

      // si on n'est pas en preparation (aka randomise image)
      if (!preparationState) {
        // compteur de couts

        // on ajoute à l'historique
        if (!historyMove) {
          _stepCount += 1;

          movesHistory.add(TileCoord(x: relx, y: rely));
        } else {
          _stepCount -= 1;
        }
      }

      if (!preparationState) {
        // on lance la simulation pour finir le jeu
        computeMinimumStepCount();
      }

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

/**
 * Annuler le dernier mouvement si c'est possible
 */
  void undoLastMove() {
    if (movesHistory.length <= 0) {
      return;
    }

    TileCoord lastMove = movesHistory.removeLast();

    moveTile(-lastMove.x, -lastMove.y, false, true);
  }

  void startGame() {
    if (_running) {
      return;
    }

    _running = true;
    _hasWon = false;
    _stepCount = 0;
    movesHistory.clear();

    print("starting game");
    generateTileList();

    int blankIndex = Random().nextInt(tiles.length);

    tiles[blankIndex].white = true;

    print("Tile blanche : x = " +
        tiles[blankIndex].originalX.toString() +
        " y = " +
        tiles[blankIndex].originalY.toString());

    // facile
    int sortCount = 5;

    if (_selectedDifficulty == 1) {
      sortCount = 20;
    } else if (_selectedDifficulty == 2) {
      sortCount = 40;
    } else if (_selectedDifficulty == 3) {
      sortCount = 60;
    }

    for (int i = 0; i < sortCount; i++) {
      if (random.nextBool()) {
        moveTile(random.nextBool() ? -1 : 1, 0, true, false);
      } else {
        moveTile(0, random.nextBool() ? -1 : 1, true, false);
      }
    }

    setState(() {});
  }

/**
 * Renvoit un index à partir d'une coordonnée
 */
  int getIndexFromCoord(TileCoord coord) {
    return coord.x + _lineSize * (coord.y - 1) - 1;
  }

/**
 * Indique si un tableau de tiles est complété
 */
  bool isFinished(List<_ImageTile> paramTiles) {
    int index = 0;

    bool w = true;
    for (var y = 1; y <= _lineSize; y++) {
      for (var x = 1; x <= _lineSize; x++) {
        if (paramTiles[index].originalX != x ||
            paramTiles[index].originalY != y) {
          w = false;
          break;
        }

        index += 1;
      }
    }

    return w;
  }

/**
 * Vérifie si la personne à gagné
 */
  void checkVictory() {
    if (isFinished(tiles)) {
      _hasWon = true;
      print("VICTOIRE !!!!!");
      _controllerCenter.play();

      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Victoire !',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Vous avez gagné en ' +
                          _stepCount.toString() +
                          " coups !",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                  Container(
                    child: ElevatedButton(
                      child: const Text('Fermer'),
                      onPressed: () {
                        Navigator.pop(context);

                        _controllerCenter.stop();

                        setState(() {
                          _hasWon = false;
                          _running = false;
                        });
                      },
                    ),
                    margin: EdgeInsets.all(10),
                  )
                ],
              ),
            ),
          );
        },
      ).whenComplete(() {
        _controllerCenter.stop();

        setState(() {
          _hasWon = false;
          _running = false;
        });
      });
    }
  }

/**
 * Renvoit des coordonnées à partir d'un index
 */
  TileCoord getCoordsFromIndex(int index) {
    int line = 1;

    int r = index;

    while (r > _lineSize - 1) {
      r -= _lineSize;
      line++;
    }

    int col = (index % _lineSize) + 1;

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
                    moveTile(-relx, -rely, false, false);
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

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Images GridView'),
        ),
        body: Stack(children: [
          Column(
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
              !_running
                  ? Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          DropdownButton<int>(
                            value: _selectedDifficulty,
                            alignment: Alignment.bottomLeft,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (int? value) {
                              setState(() {
                                _selectedDifficulty = value!;
                              });
                            },
                            items: [
                              DropdownMenuItem<int>(
                                  value: 0, child: Text("Facile")),
                              DropdownMenuItem<int>(
                                  value: 1, child: Text("Moyen")),
                              DropdownMenuItem<int>(
                                  value: 2, child: Text("Difficile")),
                              DropdownMenuItem<int>(
                                  value: 3, child: Text("Très Difficile")),
                            ],
                          )
                        ],
                      ),
                    )
                  : SizedBox(width: 0, height: 0),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: !_running
            ? FloatingActionButton(
                onPressed: () {
                  startGame();
                },
                tooltip: 'Lancer la partie',
                child: const Icon(Icons.play_arrow),
              )
            : FloatingActionButton(
                onPressed: movesHistory.length > 0
                    ? () {
                        undoLastMove();
                      }
                    : null,
                tooltip: 'Annuler dernier mouvement',
                child: const Icon(Icons.undo),
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
                  !_running
                      ? IconButton(
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
                        )
                      : Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            _stepCount.toString() + " coups",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                  const Spacer(),
                  !_running
                      ? IconButton(
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
                        )
                      : SizedBox(width: 0, height: 0),
                  const Spacer()
                ],
              ),
            )));
  }
}
