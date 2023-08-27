import 'dart:async';

import 'package:flappybird_flutter/models/box_model.dart';
import 'package:flappybird_flutter/models/pipe_model.dart';
import 'package:flappybird_flutter/widgets/ground.dart';
import 'package:flappybird_flutter/widgets/pipe.dart';
import 'package:flutter/material.dart';

class PipesSheet extends StatefulWidget {
  const PipesSheet({super.key, this.onChange, required this.active});
  final void Function(BoxModel? box, BoxModel? pipe)? onChange;
  final bool active;

  @override
  State<PipesSheet> createState() => _PipesSheetState();
}

class _PipesSheetState extends State<PipesSheet> {
  final _boxkey = GlobalKey();
  BoxModel? _gapBox;

  List<PipeModel> _pipes = [];
  double _gap = 0;
  double _groundOffset = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PipesSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.active) {
      _start();
    } else {
      _reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Column(
      children: [
        Expanded(
          key: _boxkey,
          child: Stack(
            children: [
              for (var i = 0; i < _pipes.length; ++i)
                Pipe(
                  key: Key("pipe ${_pipes[i].key}"),
                  offset: _pipes[i].offset,
                  onChange: i == 0 ? (p0) => (_gapBox = p0) : null,
                )
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (-_groundOffset >= constraints.biggest.width) {
              _groundOffset = 0;
            }

            return Ground(
              dx: _groundOffset,
            );
          },
        )
      ],
    ));
  }

  void _addNewPipe() {
    final key = (_pipes.lastOrNull?.key ?? 0);
    _pipes.add(
        PipeModel(key: key + 1, offset: MediaQuery.of(context).size.width));
  }

  void _start() async {
    if (_timer?.isActive ?? false) return;
    DateTime last = DateTime.now();

    _timer = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      int dt = DateTime.now().difference(last).inMilliseconds;

      setState(() {
        for (int i = 0; i < _pipes.length; ++i) {
          if (_pipes[i].offset <= -Pipe.width) {
            _pipes.removeAt(0);
            --i;
            continue;
          }

          _pipes[i].offset -= 0.16 * dt;
        }
        _groundOffset -= 0.16 * dt;

        if (_gap >= 1000) {
          _addNewPipe();
          _gap = 0;
        }
      });

      _gap += dt * .4;

      last = DateTime.now();

      widget.onChange?.call(
          BoxModel.fromRenderBox(
              _boxkey.currentContext?.findRenderObject() as RenderBox),
          _gapBox);
    });
  }

  void _reset() {
    setState(() {
      _timer?.cancel();
      _gapBox = null;
      _pipes = [];
      _gap = 0;
      _groundOffset = 0;
    });
  }
}
