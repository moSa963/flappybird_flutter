import 'package:flutter/material.dart';

class Ground extends StatelessWidget {
  const Ground({super.key, this.dx = 0});
  final double dx;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: OverflowBox(
          alignment: Alignment.centerLeft,
          maxWidth: MediaQuery.of(context).size.width * 2,
          child: Transform.translate(
            offset: Offset(dx, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "lib/assets/images/ground.png",
                      ),
                      repeat: ImageRepeat.repeatX,
                      fit: BoxFit.fitHeight)),
            ),
          )),
    );
  }
}
