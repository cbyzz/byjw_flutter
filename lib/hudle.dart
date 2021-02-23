import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Hudle extends StatefulWidget {
  @override
  int level;
  int duration;
  double lastAxisX;

  Hudle({Key key, this.level, this.lastAxisX, this.duration}) : super(key: key);

  @override 
  HudleState createState() => HudleState();
}

class HudleState extends State<Hudle> {
  bool _disposed = false;
  double axisX = 1.5;
  static bool ran = new Random().nextBool();
  double axisY = ran ? 1.0 : -1.0;
  
  
  @override
  void initState() {
    super.initState();

   Timer.periodic(new Duration(milliseconds: 50), (timer) {
      if(mounted) {
        setState(() {
          axisX -= 0.02;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.duration),
      alignment: Alignment(axisX, axisY),
      child: Container(
        width:30,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}