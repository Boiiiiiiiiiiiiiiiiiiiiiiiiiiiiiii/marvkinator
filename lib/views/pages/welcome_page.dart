import 'package:akinator/background_wrapper.dart';
import 'package:akinator/views/widget_tree.dart';
import 'package:akinator/views/widgets/hovering_sprite.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_1.png"),
                    ),
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_2.png")
                    ),
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_3.png")
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Akinator',
                      style: TextStyle(
                          fontFamily: 'Avengers',
                          fontSize: 40,
                          letterSpacing: 1.5
                      ),
                    ),
                    Text(
                      'Marvel ed.',
                      style: TextStyle(
                          fontFamily: 'Avengers',
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 50,),
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => WidgetTree(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  alwaysIncludeSemantics: true,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                            ),
                          );
                        }, 
                        child: Text(
                          "Start",
                          style: TextStyle(fontWeight: FontWeight.w700),
                          )
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_5.png")
                    ),
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_6.png")
                    ),
                    HoveringSprite(
                      offsetB: 0,
                      offsetG: 0,
                      offsetR: 0,
                      multB: 1,
                      multG: 1,
                      multR: 1,
                      child: Image.asset("assets/sprites/akinator_7.png")
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}