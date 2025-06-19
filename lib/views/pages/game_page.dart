import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:akinator/data/notifiers.dart';
import 'package:akinator/utils/page_routing.dart';
import 'package:akinator/views/widgets/hovering_sprite.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String question = "Загружаем вопрос...";
  Map<String, String> traitScores = {
    'dontKnowValue': '0',
  };
  int dontKnowValue = 0;
  int sprite_1 = Random().nextInt(11)+1;
  int sprite_2 = Random().nextInt(11)+1;
  int sprite_3 = Random().nextInt(11)+1;
  int sprite_4 = Random().nextInt(11)+1;

  @override
  void initState() {
    super.initState();
    proceedTheGame();
    dontKnowValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Column(
                    children: [
                      HoveringSprite(
                        offsetR: 125,
                        offsetG: 125,
                        offsetB: 275,
                        multR: 0,
                        multG: 0,
                        multB: 0,
                        child: Image.asset("assets/sprites/hover_sprite_$sprite_1.png",)
                      ),
                      SizedBox(height: 15,),
                      HoveringSprite(
                        offsetR: 125,
                        offsetG: 125,
                        offsetB: 275,
                        multR: 0,
                        multG: 0,
                        multB: 0,
                        child: Image.asset("assets/sprites/hover_sprite_$sprite_2.png")
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.60, 
                  child: FittedBox(
                    fit: BoxFit.contain, // important: keeps aspect ratio
                    child: Image.asset("assets/sprites/akinator_${(reductionRateNorifier.value / 0.145).floor() + 1}.png"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Column(
                    children: [
                      HoveringSprite(
                        offsetR: 125,
                        offsetG: 125,
                        offsetB: 275,
                        multR: 0,
                        multG: 0,
                        multB: 0,
                        child: Image.asset("assets/sprites/hover_sprite_$sprite_3.png")
                      ),
                      SizedBox(height: 15,),
                      HoveringSprite(
                        offsetR: 125,
                        offsetG: 125,
                        offsetB: 275,
                        multR: 0,
                        multG: 0,
                        multB: 0,
                        child: Image.asset("assets/sprites/hover_sprite_$sprite_4.png")
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(
              question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Avengers_Cyrillic'
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: () async {
                        String trait = await fetchTraitByQuestion(question);
                        setState(() {
                          traitScores[trait] = "1";
                        });
                        dontKnowValue=0;
                        traitScores['dontKnowValue']='0';
                        proceedTheGame();
                    }, 
                    child:Text("Да"))
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: () async {
                        String trait = await fetchTraitByQuestion(question);
                        setState(() {
                          traitScores[trait] = "1";
                        });
                        dontKnowValue=0;
                        traitScores['dontKnowValue']='0';
                        proceedTheGame();
                    }, 
                    child:Text("Частично/Вероятно"))
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        dontKnowValue++;
                        traitScores['dontKnowValue']=dontKnowValue.toString();
                        proceedTheGame();
                        },
                      child:Text("Не знаю")
                    )
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: () async {
                        String trait = await fetchTraitByQuestion(question);
                        setState(() {
                          traitScores[trait] = "0";
                        });
                        dontKnowValue=0;
                        traitScores['dontKnowValue']='0';
                        proceedTheGame();
                    }, 
                    child:Text("Скорее нет чем да"))
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        String trait = await fetchTraitByQuestion(question);
                        setState(() {
                          traitScores[trait] = "0";
                        });
                        dontKnowValue=0;
                        traitScores['dontKnowValue']='0';
                        proceedTheGame();
                      }, 
                      child:Text("Нет")
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //получить вопрос по трейту
  void fetchQuestion(String trait) async{
    Uri uri = Uri.https('app-a2989357-1f55-4709-adfc-df0a25cdbbd8.cleverapps.io', '/question.php', {
      'trait': trait
    });

    http.Response response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },);

    if (!mounted) return;

    if(response.statusCode == 200 && jsonDecode(response.body).runtimeType != bool){
      setState(() {
        Map<String, dynamic> res = jsonDecode(response.body);
        question = res['question'];
      });
    }
    else{
      question = "${response.statusCode}, reason: ${response.reasonPhrase}";
    }
  }

  //получить трейт соответствующий вопросу
  //я знаю что этот и верхний скрипт можно было объединить каким то хитрым образом
  //я слишком тупой, give me a break
  Future<String> fetchTraitByQuestion(String question) async {
    Uri uri = Uri.https('app-a2989357-1f55-4709-adfc-df0a25cdbbd8.cleverapps.io', '/trait_by_question.php', {
      'question': question
    });

    //print("Fetching from: ${uri.toString()}"); // дебаг

    http.Response response = await http.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res.containsKey('trait')) {
        return res['trait'];
      } else {
        return "Error: ${res['error']}";
      }
    } else {
      return "Error ${response.statusCode}: ${response.reasonPhrase}";
    }
  }

  //пикнуть наименее встречающийся трейт исходя из трейтов которые у нас есть
  Future<Map<String, dynamic>> fetchBestTrait(Map<String, String> traitScores) async {
    // Строим query-параметры
    Uri uri = Uri.https('app-a2989357-1f55-4709-adfc-df0a25cdbbd8.cleverapps.io', '/fetch_least_trait.php', traitScores);

    http.Response response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var body = response.body;
    print("Response: $body");

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res;
    } else {
      return {"error ${response.statusCode}": response.reasonPhrase};
    }
  }

  Future<Map<String, dynamic>> fetchHeroById(int id) async{
    Uri uri = Uri.https('app-a2989357-1f55-4709-adfc-df0a25cdbbd8.cleverapps.io', '/fetch_hero_by_id.php', {"id":id.toString()});

    http.Response response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res;
    } else {
      return {'error':"Error ${response.statusCode}: ${response.reasonPhrase}"};
    }
  }

  void proceedTheGame() async {
    try {
      Map<String, dynamic> response = await fetchBestTrait(traitScores);

      String? trait;
      int? id;
      String? error;

      if (response.containsKey('trait')) {
        trait = response['trait'];
      } else if (response.containsKey('id')) {
        id = response['id'];
      } else {
        error = response['error'];
      }

      if (id != null) {
        Map<String, dynamic> hero = await fetchHeroById(id);
        heroNameNotifier.value = hero['name'];
        heroImageLinkNotifier.value = hero['image_link'];
        selectedPageNotifier.value = 1;
      } else if (trait != null) {
        fetchQuestion(trait);
        reductionRateNorifier.value = response['ratio'];
      } else {
        if(!mounted) return;
        handleErrors(context, error);
      }
    } catch (e) {
      if(!mounted) return;
      handleErrors(context, e);
    }
  }

  //хэндлим все вообще ошибки которые я смог вспомнить
  void handleErrors(BuildContext context, dynamic error) {
  if (!mounted) return;

  if (error is String) {
    switch (error) {
      case "Мы не знаем героев которые подходят под описание...":
        toResults(context, "loose", "Я не знаю персонажей, подходящих твоему описанию...");
        return;
      case "No traits left to analyze":
        toResults(context, "loose", "Я спросил всё, что мог, но всё ещё не знаю, кого ты загадал...");
        return;
      case "No traits left to analyze after skipping":
        toResults(context, "loose", "Вы вообще ничего не знаете о своём герое... Пожалуйста, загадайте другого.");
        return;
      default:
        toResults(context, "loose", "Произошла неизвестная ошибка. Попробуйте ещё раз.");
        return;
    }
  } else if (error is SocketException) {
    toResults(context, "loose", "Нет подключения к интернету. Пожалуйста, проверьте сеть.");
  } else if (error is HttpException) {
    toResults(context, "loose", "Ошибка сервера. Пожалуйста, попробуйте позже.");
  } else if (error is FormatException) {
    toResults(context, "loose", "Некорректный ответ от сервера. Попробуйте ещё раз.");
  } else {
    toResults(context, "loose", "Неизвестная ошибка: ${error.toString()}");
    }
  }
}
//DAAAMN, 346 LINES!? I gotta learn optimizing or smt...