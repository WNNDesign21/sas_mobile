import 'package:flutter/material.dart';
import 'dart:math' as math;

class Iphone16promax12Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Iphone16promax12Widget - FRAME
    return Container(
        width: 440,
        height: 956,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 956,
              left: 0,
              child: Transform.rotate(
                angle: 90 * (math.pi / 180),
                child: Container(
                    width: 768,
                    height: 440,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/231.png'),
                          fit: BoxFit.fitWidth),
                    )),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 440,
                  height: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(53),
                      bottomRight: Radius.circular(53),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment(-1.091435350986103e-7, 1),
                        end: Alignment(
                            -9.877551078796387, -1.3861121317404468e-7),
                        colors: [
                          Color.fromRGBO(79, 1, 2, 0.9900000095367432),
                          Color.fromRGBO(151, 41, 54, 0.9953144192695618),
                          Color.fromRGBO(194, 0, 30, 1)
                        ]),
                  ))),
          Positioned(
              top: 71,
              left: 170,
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Baloo',
                    fontSize: 32,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 33,
              left: 375,
              child: Container(
                  width: 42,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Logoutrounded.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 32,
              left: 20,
              child: Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Menu.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }
}
