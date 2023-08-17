import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  const Bird({super.key});

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
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        top: 0,
        child: GestureDetector(
            onTap: _handleTap,
            child: Container(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(200, _dy),
                    child: Container(
                      key: _key,
                      color: Colors.red,
                      height: 32,
                      width: 55,
                    ),
                  ),
                ))));
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

  void _start() async {
    while (_active) {
      _time += 0.01;
      setState(() {
        _dy += (9.8 * _time) * 0.1;
      });

      final d = _key.currentContext?.findRenderObject() as RenderBox?;

      if (d != null) {
        print(d.localToGlobal(Offset.zero).dy);
      } else {
        print(null);
      }
      
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
