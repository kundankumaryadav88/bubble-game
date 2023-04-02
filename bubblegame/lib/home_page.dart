import 'dart:async';

import 'package:bubblegame/ball.dart';
import 'package:bubblegame/missile.dart';
import 'package:bubblegame/mybutton.dart';
import 'package:bubblegame/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;
  double missileX = playerX;
  double missileHeight = 10;
  bool midShot = false;

  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;
  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 60;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //quadratic equation

      height = -5 * time * time + velocity * time;

      //if the ball reach the ground then restart
      if (height < 0) {
        time = 0;
      }

      setState(() {
        ballY = heightToCoordinate(height);
      });

      if (ballX - 0.005 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX - 0.005 > 1) {
        ballDirection = direction.LEFT;
      }

      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.005;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.005;
        });
      }
      if (playersDies()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Colors.grey,
            title: Center(
              child: Text(
                "You Dead",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  void move_left() {
    setState(() {
      if (playerX - 0.1 < -1) {
        //do nothing
      } else {
        playerX -= 0.1;
      }

      if (!midShot) {
        missileX = playerX;
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
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  void fire_missle() {
    if (midShot == false) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        midShot = true;

        setState(() {
          missileHeight += 10;
        });
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }
        if (ballY > heightToCoordinate(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  void resetMissile() {
    missileHeight = playerX;
    missileHeight += 10;
    midShot = false;
  }

  bool playersDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

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
                    Ball(
                      ballX: ballX,
                      ballY: ballY,
                    ),
                    Missile(missileX: missileX, height: missileHeight),
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
                  icon: const Icon(Icons.play_arrow),
                  function: startGame,
                ),
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
