import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapGrid extends StatefulWidget {
  const MapGrid({Key key, this.gridState}) : super(key: key);

  @required
  final List<List<String>> gridState;

  @override
  _MapGridState createState() => _MapGridState();
}

class _MapGridState extends State<MapGrid> {
  void changeTile(int x, int y) {
    List<String> races = [
      'lizzard',
      'beast',
      'ancientVampire',
      'bird',
      'character',
      'crocodile'
    ];

    widget.gridState[x][y] = races[Random().nextInt(races.length)];
  }

  bool tileSelection = false;

  String saveTileStateA;
  String saveTileStateB;
  int saveX;
  int saveY;

  void selectTile(int x, y) {
    if (widget.gridState[x][y] == '') {
      print('');
      return;
    }

    saveX = x;
    saveY = y;
    saveTileStateA = widget.gridState[x][y];
    tileSelection = true;

    print(saveX);
    print(saveY);
    print(saveTileStateA);
    print(tileSelection);
  }

  void switchTile(int x, int y) {
    saveTileStateB = widget.gridState[x][y];

    widget.gridState[x][y] = saveTileStateA;

    widget.gridState[saveX][saveY] = saveTileStateB;
    tileSelection = false;

    // String tempState;

    // tempState = gridState[x][y];
    // gridState[x][y] = saveTileState;

    // gridState[saveX][saveY] = tempState;
    // tileSelection = false;
  }

  Widget tile(int x, int y) {
    switch (widget.gridState[x][y]) {
      case '':
        {
          return Text('');
        }
        break;

      case 'lizzard':
        {
          return SvgPicture.asset(
            'assets/races/lizzard.svg',
            color: Colors.black,
          );
        }

        break;
      case 'beast':
        {
          return SvgPicture.asset(
            'assets/races/beast.svg',
            color: Colors.black,
          );
        }

        break;
      case 'ancientVampire':
        {
          return SvgPicture.asset(
            'assets/races/ancientVampire.svg',
            color: Colors.black,
          );
        }

        break;
      case 'bird':
        {
          return SvgPicture.asset(
            'assets/races/bird.svg',
            color: Colors.black,
          );
        }

        break;
      case 'character':
        {
          return SvgPicture.asset(
            'assets/races/character.svg',
            color: Colors.black,
          );
        }

        break;
      case 'crocodile':
        {
          return SvgPicture.asset(
            'assets/races/crocodile.svg',
            color: Colors.black,
          );
        }

        break;

      default:
        return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 800,
      child: GridView.builder(
          itemCount: widget.gridState.length * widget.gridState.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridState.length,
          ),
          itemBuilder: (BuildContext context, int index) {
            int x, y = 0;
            x = (index % widget.gridState.length);
            y = (index / widget.gridState.length).floor();

            return GestureDetector(
              onDoubleTap: () {
                setState(() {
                  changeTile(x, y);
                });
              },
              onLongPress: () {
                setState(() {
                  changeTile(x, y);
                });
              },
              onTap: () {
                setState(() {
                  (tileSelection) ? switchTile(x, y) : selectTile(x, y);
                });
              },
              child: GridTile(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0)),
                  child: tile(x, y),
                ),
              ),
            );
          }),
    );
  }
}
