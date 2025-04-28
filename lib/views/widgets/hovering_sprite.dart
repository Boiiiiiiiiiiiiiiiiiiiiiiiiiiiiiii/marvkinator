import 'package:flutter/material.dart';
import 'dart:math';

//ain't gon' lie i stole this code
//each line of it

class HoveringSprite extends StatefulWidget {
  final Widget child;
  
  final double offsetR;
  final double offsetG;
  final double offsetB;

  final double multR;
  final double multG;
  final double multB;

  const HoveringSprite({
    super.key, 
    required this.child,
    required this.offsetR,
    required this.offsetG,
    required this.offsetB, 
    required this.multR, 
    required this.multG, 
    required this.multB
    });

  @override
  State<HoveringSprite> createState() => _HoveringSpriteState();
}

class _HoveringSpriteState extends State<HoveringSprite> with SingleTickerProviderStateMixin {

  

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 1), 
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double hoverSpeed = Random().nextDouble() * 2 + 1;
  double rotationSpeed = Random().nextDouble() * 2 + 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double time = _controller.lastElapsedDuration!.inMilliseconds / 1000.0;
        
        final double hoverOffset = sin(time * hoverSpeed * pi / 5) * 10; // period = 5 seconds
        final double rotationAngle = sin(time * rotationSpeed * pi / 5) * 0.05;

        return Transform.translate(
          offset: Offset(0, hoverOffset),
          child: Transform.rotate(
            angle: rotationAngle,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ColorFiltered(
                    //ok what i did not steal is this color matrix
                      colorFilter: ColorFilter.matrix(<double>[
                        widget.multR, 0, 0, 0, widget.offsetR,
                        0, widget.multG, 0, 0, widget.offsetG,
                        0, 0, widget.multB, 0, widget.offsetB,
                        0, 0, 0, 1, 0,
                      ]),
                      child: widget.child,
              )
            ),
          ),
        );
      },
    );
  }
}