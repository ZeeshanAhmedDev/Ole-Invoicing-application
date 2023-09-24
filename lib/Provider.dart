import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class DataProviders extends ChangeNotifier {
  bool showSpinner = false;
  String? getName = '';
  String? quoteVariable;
  String? dropdownValue;
  double currentSliderValue = 1;
  double customSizedBox = 60;

  late final Locale withLocal;
  String finalDate = '';

  var getTimeSheetDate;
  var weekEndingDate;

  changeValueOfLocale({required BuildContext context, required Locale locale}) {
    // Future.delayed(Duration.zero, () async {

    withLocal = context.setLocale as Locale;
    // });
    notifyListeners();
  }

  getname(String value) {
    getName = value;
    notifyListeners();
  }

  timeSheetDateMethod(var value) {
    getTimeSheetDate = value;
    notifyListeners();
  }

  weekEndingDateMethod(var value) {
    weekEndingDate = value;
    notifyListeners();
  }

  // CheckTrueOrFalse(bool value) {
  //   // Helper.showSpinner = value;
  //   notifyListeners();
  // }

  getQuote(String value) {
    quoteVariable = value;
    notifyListeners();
  }

  changeDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  changeSliderValue(double value) {
    currentSliderValue = value;
    notifyListeners();
  }

  isTrueOrFalseFunctionProgressHUD(bool value) {
    showSpinner = value;
    notifyListeners();
  }

  getFinalDate(String value) {
    finalDate = value;
    notifyListeners();
  }

  changeValueOfSizedBox({required double value}) {
    Future.delayed(Duration.zero, () async {
      customSizedBox = value;
    });
    notifyListeners();
    log("customSizedBox == " + customSizedBox.toString());
  }
}
