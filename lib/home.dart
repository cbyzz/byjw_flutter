import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:byjw_flutter/hudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'naver-icon.dart';
import 'util.dart';


class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}


class HomeState extends State<Home>{
  static double axisY = 0;
  double jumpAxisY = axisY;
  double count = 0;
  double gravity = 0.15;
  double vector = 0;
  static double time = 1.6;
  double time2 = time + 1.5;
  bool action = false;
  int animDuration = 100;
  int animDuration2 = 100;
  double bottomHeight = 30;
  double topHeight = 30;
  double bottomHeight2 = 40;
  double topHeight2 = 40;

  int currentScore = 0;

  List arr = <Widget>[];

  void jump(){
    // print(axisY);
    setState(() {
      count = 0;
      jumpAxisY = axisY;
      /*
      axisY -= 0.2;
      axisY = double.parse(axisY.toStringAsExponential(1));
      */
    });
  }

  void start(){
    action = true;
    count = 0;
    Timer.periodic(new Duration(milliseconds: 50), (timer) {
      if(arr.length < 5 && (currentScore % 50) == 0){
        arr.add(Hudle(level: 0, duration:animDuration, lastAxisX:0));
      }else if(arr.length >= 5 && (currentScore % 50) == 0){
        arr.removeAt(0);
        arr.add(Hudle(level: 0, duration:animDuration, lastAxisX:0));
      }

      time -= 0.05;
      time2 -= 0.05;

      currentScore += 1;

      count += 0.025;
      setState((){
        // axisY = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));
        // vector = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));
        vector = double.parse((-4.9 * count * count + 2.5 * count).toStringAsExponential(1));

        axisY = jumpAxisY - vector;

        if(time <= -1.3){
          time = 1.6;
          animDuration = 0;
          var min = 50;
          var max = 250;
          var rnd = new Random();
          var r = min + rnd.nextInt(max - min);
          bottomHeight = r.toDouble();
          rnd = new Random();
          r = min + rnd.nextInt(max - min);
          topHeight = r.toDouble();
        } else {
          animDuration = 100;
        }

        if(time2 <= -1.3){
          time2 = time + 1.5;
          animDuration2 = 0;
          var min = 50;
          var max = 250;
          var rnd = new Random();
          var r = min + rnd.nextInt(max - min);
          bottomHeight2 = r.toDouble();
          rnd = new Random();
          r = min + rnd.nextInt(max - min);
          topHeight2 = r.toDouble();
        } else {
          animDuration2 = 100;
        }

        if(axisY >= 1.0){
          timer.cancel();
          endGame();
        }
      });
    });
    
  }

  endGame(){
    arr = <Widget>[];
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Die! Bitch!'),
          content: Text("Your Score " + currentScore.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
                setState((){
                  vector = 0;
                  count = 0;
                  axisY = 0;
                  jumpAxisY = 0;
                  action = false;

                  time = 1.6;
                  time2 = time + 1.5;
                  bottomHeight = 30;
                  topHeight = 30;
                  bottomHeight2 = 40;
                  topHeight2 = 40;

                  currentScore = 0;
                });
              },
            ),
            FlatButton(
              child: Text('App Close'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        onTap: (){

          if(!action){
            start();
          }else{
            jump();
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: getStatusBarHeight(context),
            ),
            Expanded(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    alignment: Alignment(0, axisY),
                    color:Colors.green,
                    child: NaverIcon(),
                  ),
                  ...arr,
                  /*
                  AnimatedContainer(
                    duration: Duration(milliseconds: animDuration),
                    alignment: Alignment(time, 1),
                    child: Container(
                      width:30,
                      height:bottomHeight,
                      color: Colors.red,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animDuration),
                    alignment: Alignment(time, -1),
                    child: Container(
                      width:30,
                      height: topHeight,
                      color: Colors.red,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animDuration2),
                    alignment: Alignment(time2, 1),
                    child: Container(
                      width:50,
                      height:bottomHeight2,
                      color: Colors.black,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animDuration2),
                    alignment: Alignment(time2, -1),
                    child: Container(
                      width:30,
                      height: topHeight2,
                      color: Colors.red,
                    ),
                  )
                  */
                ]
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                color:Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex:5,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '현재점수',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top:20, right:30, left:30),
                            child: Text(
                              currentScore.toString() + ' 점',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              ),
                          )
                        ],
                      ),
                    ),
                   Container(
                      width: 1,
                      height: double.maxFinite,
                      color: Colors.grey.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 0),
                    ),
                    Expanded(
                      flex:5,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '최고점수',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top:20, right:20, left:20),
                            child: Text(
                              '0점',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              ),
                          )
                        ],
                      ),
                    )
                  ]
                )
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}