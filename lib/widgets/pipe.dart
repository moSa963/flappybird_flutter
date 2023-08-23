import 'dart:math';

import 'package:flappybird_flutter/models/box_model.dart';
import 'package:flutter/material.dart';

class Pipe extends StatefulWidget {
  const Pipe({super.key, required this.offset, this.onChange});
  static double width = 75;
  final double offset;
  final void Function(BoxModel pipBox)? onChange;

  @override
  State<Pipe> createState() => _PipeState();
}

class _PipeState extends State<Pipe> {
  int _gap = 50;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gap = 10 + Random().nextInt(80);
    });
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
                child: _pipe(),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  widget.onChange?.call(BoxModel.fromRenderBox(
                      context.findRenderObject() as RenderBox));

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: _gap == 50 ? 0 : 160,
                  );
                },
              ),
              Expanded(
                  flex: 100 - _gap,
                  child: Transform.flip(
                    flipX: true,
                    flipY: true,
                    child: _pipe(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pipe() {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            "lib/assets/images/pipe_body.png",
            fit: BoxFit.fitWidth,
            width: Pipe.width,
            repeat: ImageRepeat.repeatY,
          ),
        ),
        Image.asset(
          "lib/assets/images/pipe_head.png",
          fit: BoxFit.fitWidth,
          width: Pipe.width,
        ),
      ],
    );
  }
}
