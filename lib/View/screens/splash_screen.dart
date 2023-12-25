import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/View/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double _deviceHeight,_deviceWidth;

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds:8), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      Container(
        height: _deviceHeight,
        width: _deviceWidth,
        color: Colors.white,
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _deviceHeight * 0.25,
              width: _deviceWidth * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/logo.png'))),
            ),
          ],
        ),
      ),
    ]);
  }
}
