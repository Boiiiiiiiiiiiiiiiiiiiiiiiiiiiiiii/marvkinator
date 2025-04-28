import 'package:flutter/material.dart';
//app notifiers
ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier(true);

//gameplay notifiers
ValueNotifier<String> heroNameNotifier = ValueNotifier("");
ValueNotifier<String> heroImageLinkNotifier = ValueNotifier("");
ValueNotifier<double> reductionRateNorifier = ValueNotifier(0.5);