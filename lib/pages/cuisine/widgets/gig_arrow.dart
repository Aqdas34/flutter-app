import 'package:flutter/material.dart';

class GigArrow extends StatelessWidget {
  final double angle;

  const GigArrow({super.key, this.angle = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Transform.rotate(
          angle: -3.14 / 50, // Correct the angle to -π/4 radians
          child: Center(
            child: Opacity(
              opacity: 1, // Modify this line to make the arrow transparent
              child: Icon(
                Icons.arrow_outward_rounded,
                color: Color.fromRGBO(0, 0, 0,
                    0.5), // Modify this line to make the arrow transparent
                size: 45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
