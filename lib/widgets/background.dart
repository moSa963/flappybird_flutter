import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: const Color.fromARGB(255, 78, 192, 202),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Column(children: [
                Expanded(
                    child: Container(
                  color: const Color.fromARGB(255, 78, 192, 202),
                )),
                Expanded(
                    child: Container(
                  color: const Color.fromARGB(255, 94, 226, 112),
                )),
              ]),
            ),
            Positioned.fill(
              child: Image.asset(
                "lib/assets/images/background.png",
                repeat: ImageRepeat.repeatX,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
