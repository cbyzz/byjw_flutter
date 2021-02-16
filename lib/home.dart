import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'naver-icon.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}


class HomeState extends State<Home>{
  double axisY = 0;
  double jumpAxisY = 0;
  double count = 0;
  double gravity = 0.15;
  double vector = 0;
  bool action = false;

  void jump(){
    setState(() {
      count = 0.05;
      jumpAxisY = axisY;
      gravity = vector/count;

      axisY = double.parse((axisY - ((gravity * (count * count)))/2).toStringAsExponential(1));
      /*
      axisY -= 0.2;
      axisY = double.parse(axisY.toStringAsExponential(1));
      */
    });
  }

  void start(){
    count = 0;

    action = true;
    Timer.periodic(new Duration(milliseconds: 50), (timer) {
      count += 0.05;
      setState((){
        axisY = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));
        vector = sqrt(2*gravity*axisY);

        if(axisY >= 1.0){
          timer.cancel();
        }
      });
    });
    
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
                duration: Duration(milliseconds: 100),
                alignment: Alignment(0, axisY),
                color:Colors.green,
                child: NaverIcon(),
              ),
              onTap: (){

                if(!action){
                  start();
                }else{
                  jump();
                }
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
    );
  }
}
