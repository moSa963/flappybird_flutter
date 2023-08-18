import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Pipe extends StatefulWidget {
  const Pipe({super.key, required this.offset});
  static double width = 75;
  final double offset;

  @override
  State<Pipe> createState() => _PipeState();
}

class _PipeState extends State<Pipe> {
  int _gap = 0;

  @override
  void initState() {
    super.initState();
    _gap = 10 + Random().nextInt(80);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Transform.translate(
        offset: Offset(widget.offset, 0),
        child: SizedBox(
          width: Pipe.width,
          child: Column(
            children: [
              Expanded(
                  flex: _gap,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/assets/images/pipe_head.png"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter),
                    ),
                  )),
              const SizedBox(
                height: 160,
              ),
              Expanded(
                  flex: 100 - _gap,
                  child: Transform.flip(
                    flipX: true,
                    flipY: true,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("lib/assets/images/pipe_head.png"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}