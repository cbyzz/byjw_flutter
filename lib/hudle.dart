import 'package:flutter/material.dart';

class Hudle extends StatefulWidget {
  @override
  HudleState createState() => HudleState();
}

class HudleState extends State<Hudle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:20
        ),
        Container(
          width:30,
          height:40,
          color: Colors.red,
        )
      ],
    );
  }
}