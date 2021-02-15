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
  double count = 0;
  double gravity = 0.15;
  bool action = false;

  void jump(){
    count = 0;

    setState(() {
      axisY -= 0.2;
      axisY = double.parse(axisY.toStringAsExponential(1));
    });

    if(!action){
      action = true;
      Timer.periodic(new Duration(milliseconds: 1000), (timer) {
        count += 0.1;
        setState((){
          axisY = double.parse((axisY + ((gravity * (count * count)))/2).toStringAsExponential(1));

          if(axisY >= 1.0){
            timer.cancel();
          }else{
            action = false;
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
