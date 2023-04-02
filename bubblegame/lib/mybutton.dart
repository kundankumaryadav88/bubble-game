import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? function;
  const MyButton({Key? key, required this.icon, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          width: 50,
          height: 50,
          child: icon,
        ),
      ),
    );
  }
}
