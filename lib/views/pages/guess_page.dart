import 'package:akinator/data/notifiers.dart';
import 'package:akinator/utils/page_routing.dart';
import 'package:flutter/material.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({
    super.key,
  });

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {

  String resultText=heroNameNotifier.value;
  String titleText="Я думаю что ваш персонаж это";
  Image image = Image.network(heroImageLinkNotifier.value);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontFamily: 'Avengers_Cyrillic',
              fontSize: 30
            ),
          ),
          Center(
            child: SizedBox(
              width: 400, 
              height: 400,
              child: FittedBox(
                fit: BoxFit.contain,
                child: image
              ),
            ),
          ),
          Text(
            resultText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Avengers_Cyrillic',
              fontSize: 25
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              FilledButton(
                onPressed: () {
                  toResults(context, "win", "Ура! Давай еще раз!");
                }, 
                child: Text(
                  "Да",
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              FilledButton(
                onPressed: () {
                toResults(context, "loose", "Вмять! В следующий раз я точно выиргаю, перезапускай!");
                }, 
                child: Text(
                  "Нет",
                  style: TextStyle(
                      fontWeight: FontWeight.w700
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}