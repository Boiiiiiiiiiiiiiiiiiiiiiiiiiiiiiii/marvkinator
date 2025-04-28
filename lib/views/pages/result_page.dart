import 'package:akinator/utils/page_routing.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.resultTitle,
  });

  final String result;
  final String resultTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Avengers_Cyrillic",
                fontSize: 30
              ),
            ),
            Center(child: Image.asset("assets/sprites/akinator_$result.png")),
            FilledButton(
              onPressed:(){restart(context);}, 
              child: Text(
                "Давай сначала!",
                style: TextStyle(
                  fontWeight: FontWeight.w700
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}