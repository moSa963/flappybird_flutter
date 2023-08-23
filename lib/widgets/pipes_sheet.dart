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

  List<PipeModel> pipes = [];
  double _gap = 0;
  double _groundOffset = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PipesSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active) return;
    _start();
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
              for (var i = 0; i < pipes.length; ++i)
                Pipe(key: Key("pipe ${pipes[i].key}"), offset: pipes[i].offset, onChange: i == 0 ? (p0) => (_gapBox = p0) : null,)
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (-_groundOffset >= constraints.biggest.width) {
              _groundOffset = 0;
            }
            
            return Ground(dx: _groundOffset,);
          },
        )
      ],
    ));
  }

  void _addNewPipe() {
    final key = (pipes.lastOrNull?.key ?? 0);
    pipes.add(PipeModel(key: key + 1, offset: MediaQuery.of(context).size.width));
  }

  void _start() async {
    while (widget.active) {
      setState(() {
        for (int i = 0; i < pipes.length; ++i) {
          if (pipes[i].offset <= -Pipe.width) {
            pipes.removeAt(0);
            --i;
            continue;
          }

          pipes[i].offset -= 0.4;
        }
        _groundOffset -= 0.4;

        if (_gap >= 1000) {
          _addNewPipe();
          _gap = 0;
        }
      });

      ++_gap;

      widget.onChange?.call(BoxModel.fromRenderBox(_boxkey.currentContext?.findRenderObject() as RenderBox), _gapBox);

      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
