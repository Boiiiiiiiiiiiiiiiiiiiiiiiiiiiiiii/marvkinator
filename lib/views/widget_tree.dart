import 'package:akinator/utils/page_routing.dart';
import 'package:akinator/views/pages/guess_page.dart';
import 'package:akinator/views/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:akinator/data/notifiers.dart';
import 'package:akinator/views/pages/game_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({
    super.key,
    this.result,
    this.resultTitle
  });

  final String? result;
  final String? resultTitle;

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [GamePage(), GuessPage(), ResultPage(result: result == null ? "win" : result!, resultTitle: resultTitle == null ? "win" : resultTitle!)];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){restart(context);}, icon: Icon(Icons.replay_outlined)),
        title: Text(
          'Akinator',
          style: TextStyle(
                fontFamily: 'Avengers',
                fontSize: 26,
                letterSpacing: 1.5
          ),
        ),
        actions: [
          ValueListenableBuilder(valueListenable: isDarkThemeNotifier, builder: (context, isDark, child) {
            return IconButton(
              onPressed: () async{
                isDarkThemeNotifier.value = !isDarkThemeNotifier.value;
              }, 
              icon: isDarkThemeNotifier.value ? Icon(Icons.dark_mode) : Icon(Icons.sunny)
            );
          },
          ),
        ],
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
    );
  }
}