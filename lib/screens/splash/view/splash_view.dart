import 'package:flutter/material.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        height: context.cHeight,
        width: context.cWidth,
        // color: Color.fromRGBO(247, 247, 247, 1.0),
        color: Colors.black,

        // child:
        // Image.asset(
        //   splashImg,
        //   // splashImgIos,
        //   width: context.cWidth / 1.5,
        // ).cToCenter,
      ),
    );
  }
}
