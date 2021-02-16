import 'package:flutter/material.dart';

num getStatusBarHeight (BuildContext context) => MediaQuery.of(context).padding.top;
num getDeviceWith (BuildContext context) => MediaQuery.of(context).size.width;