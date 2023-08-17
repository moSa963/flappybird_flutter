import 'package:flappybird_flutter/widgets/pipe.dart';
import 'package:flutter/material.dart';

class PipesSheet extends StatefulWidget {
  const PipesSheet({super.key});

  @override
  State<PipesSheet> createState() => _PipesSheetState();
}

class _PipesSheetState extends State<PipesSheet> {
  List<double> pipes = [];
  double _gap = 0;
  bool _active = true;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          for (var i = 0; i < pipes.length; ++i) Pipe(offset: pipes[i])
        ],
      ),
    );
  }

  void _addNewPipe() {
    pipes.add(MediaQuery.of(context).size.width);
  }

  void _start() async {
    while (_active) {
      setState(() {
        for (int i = 0; i < pipes.length; ++i) {
          pipes[i] -= 0.1;
        }

        if (_gap >= 3000) {
          _addNewPipe();
          _gap = 0;
        }
      });

      ++_gap;
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
