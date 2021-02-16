import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
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
  double time = 1.3;
  bool action = false;

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
      time -= 0.05;
      count += 0.025;
      setState((){
        // axisY = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));
        // vector = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));
        vector = double.parse((-4.9 * count * count + 2.5 * count).toStringAsExponential(1));

        axisY = jumpAxisY - vector;

        if(time <= -1.3){
          time = 1;
        }

        if(axisY >= 1.0){
          vector = 0;
          count = 0;
          axisY = 0;
          jumpAxisY = 0;
          action = false;
          timer.cancel();
        }
      });
    });
    
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
                  AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    alignment: Alignment(time, 1),
                    child: Container(
                      width:30,
                      height:40,
                      color: Colors.red,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    alignment: Alignment(0, -1),
                    child: Container(
                      width:30,
                      height:getStatusBarHeight(context),
                      color: Colors.red,
                    ),
                  )
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
                              '21812123121231231점',
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
