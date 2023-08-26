import 'package:flappybird_flutter/models/box_model.dart';
import 'package:flutter/material.dart';

class PipeGap extends StatefulWidget {
  const PipeGap({super.key, this.onChange});
  final void Function(BoxModel pipBox)? onChange;

  @override
  State<PipeGap> createState() => _PipeGapState();
}

class _PipeGapState extends State<PipeGap> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        widget.onChange?.call(
            BoxModel.fromRenderBox(context.findRenderObject() as RenderBox));
        return Container(
          height: 160,
        );
      },
    );
  }
}
