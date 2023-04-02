import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  final double missileX;
  final double height;
  const Missile({Key? key, required this.missileX, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, 1),
      child: Container(
        width: 2,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}
