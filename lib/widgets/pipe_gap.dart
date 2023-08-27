import 'package:flappybird_flutter/models/box_model.dart';
import 'package:flutter/material.dart';

class PipeGap extends StatefulWidget {
  const PipeGap({super.key, this.onChange});
  final void Function(BoxModel pipBox)? onChange;

  @override
  State<PipeGap> createState() => _PipeGapState();
}

class _PipeGapState extends State<PipeGap> {
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          widget.onChange?.call(
              BoxModel.fromRenderBox(context.findRenderObject() as RenderBox));
        });
        return AnimatedSize(
          duration: const Duration(seconds: 1),
          child: SizedBox(
            height: _height,
          ),
        );
      },
    );
  }

  void _start() async {
    await Future.delayed(const Duration(microseconds: 100));
    setState(() {
      _height = 120;
    });
  }
}
