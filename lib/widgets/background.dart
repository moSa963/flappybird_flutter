


import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        color: const Color.fromARGB(255, 78, 192, 202),
        child: Image.asset("lib/assets/images/background.png",  repeat: ImageRepeat.repeatX,),
      ),
    );
  }
}