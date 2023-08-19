import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  const Bird({super.key, this.onMoved});
  final void Function(RenderBox?)? onMoved;

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  final _key = GlobalKey();
  double _dy = 0;
  bool _active = false;
  double _time = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: GestureDetector(
            onTap: _handleTap,
            child: Container(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(75, _dy),
                    child: _birdBody(),
                  ),
                ))));
  }

  Widget _birdBody() {
    return Transform.rotate(
      angle: _angle(),
      child: Container(
        key: _key,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/images/bird.png"),
                fit: BoxFit.fill)),
        height: 35,
        width: 50,
      ),
    );
  }

  void _handleTap() {
    setState(() {
      if (!_active) {
        _active = true;
        _start();
      }
      _time = -1.2;
    });
  }

  double _angle() {
    return _time < 3 ? _time / 4 : 1;
  }

  void _start() async {
    while (_active) {
      _time += 0.01;

      setState(() {
        _dy += 0.98 * _time;
      });

      widget.onMoved
          ?.call(_key.currentContext?.findRenderObject() as RenderBox?);

      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
