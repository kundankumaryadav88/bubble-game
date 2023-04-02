import 'package:bubblegame/mybutton.dart';
import 'package:bubblegame/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double playerX = 0;

  void move_left() {
    setState(() {
      if (playerX - 0.1 < -1) {
        //do nothing
      } else {
        playerX -= 0.1;
      }
    });
  }

  void move_right() {
    setState(() {
      if (playerX + 0.1 < -1) {
        //do nothing
      } else {
        playerX += 0.1;
      }
    });
  }

  void fire_missle() {}

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          move_left();
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          move_right();
        }
        if (value.isKeyPressed(LogicalKeyboardKey.space)) {
          fire_missle();
        }
      },
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.pinkAccent,
                child: Center(
                    child: Stack(
                  children: [
                    Player(
                      playerX: playerX,
                    )
                  ],
                )),
              )),
          Expanded(
              child: Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  icon: const Icon(Icons.arrow_back),
                  function: move_left,
                ),
                MyButton(
                  icon: const Icon(Icons.arrow_upward),
                  function: fire_missle,
                ),
                MyButton(
                  icon: const Icon(Icons.arrow_forward),
                  function: move_right,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
