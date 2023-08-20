import 'package:flutter/material.dart';

class BoxModel {
  final double top;
  final double bottom;
  final double left;
  final double right;

  BoxModel({this.top=0.0, this.bottom=0.0, this.left=0.0, this.right=0.0});

  factory BoxModel.fromRenderBox(RenderBox box) {
    final offset = box.localToGlobal(Offset.zero);

    return BoxModel(
      top: offset.dy,
      left: offset.dx,
      bottom: offset.dy + box.size.height,
      right: offset.dx + box.size.width,
    );
  }
}