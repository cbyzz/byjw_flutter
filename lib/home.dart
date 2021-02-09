import 'dart:async';

import 'package:flutter/material.dart';
import 'naver-icon.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}


class HomeState extends State<Home>{
  double axisY = 0;
  int count = 0;
  bool action = false;

  void jump(){
    setState(() {
      axisY -= 0.1;
      axisY = double.parse(axisY.toStringAsExponential(1));
      count = 0;
    });

    if(!action){
      action = true;
      Timer.periodic(new Duration(milliseconds: 500), (timer) {
        count += 1;
        setState((){
          axisY += (0.1 * count);
          axisY = double.parse(axisY.toStringAsExponential(1));

          if(axisY >= 1.0){
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                alignment: Alignment(0, axisY),
                color:Colors.green,
                child: NaverIcon(),
              ),
              onTap: (){
                jump();
              },
            ),
            flex: 4,
          ),
          Expanded(
            child: Container(
              color:Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('현재점수'),
                      Text(
                        '2181212312312312',
                        softWrap: true,
                        )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('최고점수'),
                      Text('0')
                    ],
                  )
                ]
              )
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
