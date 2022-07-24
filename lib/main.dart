import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

  var winner = "";
  var currentplayer = 'x';
  void drawxo(i) {
    setState(() {
      if (grid[i] == '-') {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'x' ? 'O' : 'x';
      }
    });
    findwinner(grid[i]);
  }

  bool checkmove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findwinner(currentsign) {
    if (checkmove(0, 1, 2, currentsign) ||
        checkmove(3, 4, 5, currentsign) ||
        checkmove(6, 7, 8, currentsign) ||
        checkmove(1, 4, 7, currentsign) ||
        checkmove(2, 5, 8, currentsign) ||
        checkmove(0, 3, 6, currentsign) ||
        checkmove(0, 4, 8, currentsign) ||
        checkmove(2, 4, 6, currentsign)) {
      setState(() {
        winner = currentsign;
      });
      print('$currentsign won');
    }
  }

  void reset() {
    setState(() {
      winner = '';
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  reset();
                },
                icon: Icon(Icons.refresh),
                label: Text('Play Again')),
            if (winner != "")
              Text(
                '$winner is won the game',
                style: TextStyle(fontSize: 30),
              ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                color: Colors.black,
                margin: EdgeInsets.all(8),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) => Material(
                    color: Colors.teal,
                    child: InkWell(
                      onTap: () => drawxo(index),
                      splashColor: Colors.black,
                      child: Center(
                        child: Text(
                          grid[index],
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                  itemCount: grid.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
