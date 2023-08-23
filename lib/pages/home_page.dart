import 'package:flappybird_flutter/models/box_model.dart';
import 'package:flappybird_flutter/widgets/background.dart';
import 'package:flappybird_flutter/widgets/bird.dart';
import 'package:flappybird_flutter/widgets/pipes_sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BoxModel? box;
  BoxModel? gap;
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.transparent,
      constraints: const BoxConstraints(minHeight: 1000),
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Background(),
          PipesSheet(
            active: active,
            onChange: (box, pipe) {
              this.box = box;
              gap = pipe;
            },
          ),
          Bird(
            onTap: () {
              if (active) return;
              setState(() {
                active = true;
              });
            },
            active: active,
            onMoved: (birdBox) {
              if (birdBox!.bottom > box!.bottom || birdBox!.top < box!.top) {
                setState(() {
                  active = false;
                });
              }

              if (gap == null) return;

              if (birdBox.right >= gap!.left && birdBox.left < gap!.right) {
                if (birdBox.top < gap!.top || birdBox.bottom > gap!.bottom) {
                  setState(() {
                    active = false;
                  });
                }
              }
            },
          ),
        ],
      ),
    ));
  }
}
