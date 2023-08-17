import 'package:flutter/material.dart';

class Pipe extends StatefulWidget {
  const Pipe({super.key, required this.offset});
  static double width = 75;
  final double offset;

  @override
  State<Pipe> createState() => _PipeState();
}

class _PipeState extends State<Pipe> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Transform.translate(
        offset: Offset(widget.offset , 0),
        child: Container(
          width: Pipe.width,
          color: Colors.blue,
        ),
      ),
    );
  }
}
