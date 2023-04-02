import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  const Ball({Key? key, required this.ballX, required this.ballY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 10,
        width: 10,
        decoration:
            const BoxDecoration(color: Colors.brown, shape: BoxShape.circle),
      ),
    );
  }
}
