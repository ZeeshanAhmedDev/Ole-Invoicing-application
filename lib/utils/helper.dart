import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ole_app/Provider.dart';
import 'package:provider/provider.dart';
import 'package:snack/snack.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/NewFinalScreen/SelectCategories/newModelForCategory.dart';
import 'constant.dart';

class Helper {
  static var getTimeDifference;
  static var index = 0;
  // static var str;
  static List<String> strList = [];
  static List<CategoriesModel> strListOfCategories = [];

  /// ******************* Lists to hold data for Create invoice screen for customers****************************/ //
  static List<String> dropdownNames = [];
  static List<String> dropdownNamesForWorkers = [];
  static List<String> dropdownNameListForSelectClientScreen = [];

  /// ***********************************************/ //

  static var showAllDataForEverything;
  static List<String> selectCustomers = [];

  ///================================ Only Alphabets with space Regex start ==================================
  static final regExpForOnlyAlphabetsWithSpace = RegExp(r'^[a-zA-Z\s]*$');

  ///================================ Only Alphabets with space Regex END ==================================

  /// ======================================= ///
  static getReferenceFireStore(String collection) {
    final CollectionReference clientss =
        FirebaseFirestore.instance.collection(collection);
  }

  /// ======================================= ///

  /// =================================================================================================== ///
  static List<String> selectedCategories = [];

  static Map<String, double> categoriesNeeded = {};

  /// =================================================================================================== ///
  static String time = '';
  static String time2invoiceNO = '';
  static bool showRemainingData = false;
  static bool isShowed = false;
  //============================================================================INVOICE SCREEN VARIABLE
  // ignore: prefer_typing_uninitialized_variables
  static var docs;
  // ignore: prefer_typing_uninitialized_variables
  static var data;

  //============================================================================
  static TextStyle styleForText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 25.sp,
  );
  static SizedBox customSizedBox = SizedBox(
    height: 15.h,
  );
  static bool isInternetConnected = false;
  static bool showSpinner = false;
  static bool isLastPage = false;

  static String? chosenValue;
  static int count = 0;
  static var showDateOfCalender;

  static List<String> dropDownListOfDataForPerson = ['Person 1', 'Person 2'];
  static List<Widget> listForDynamicWidgets = [];
  static List<Widget> distinctIds = [
    ...{...listForDynamicWidgets}
  ];
  // final distinctIds = [...{...ids}];
  static List<String> choosenlist = [];
  static List<String> dropDownListOfDataForWorker = ['Worker 1', 'Worker 1'];
  static List<String> selectedItems = [];

  static List<String> selectedClients = [];

  static List<Widget> dataWidget = [
    Text("ddd"),
    Text("ddd"),
    Text("ddd"),
    Text("ddd"),
    Text("ddd")
  ];

  /// Method to Convert DateTime Into *** DAY ***
  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormatter = DateFormat("d-M-yyyy");
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  /// ================================================= ///
  static calcWorkHours(var startTime, var endTime) {
    final DateTime checkInTime = startTime;
    final DateTime checkOutTime = endTime;

    final hours = checkOutTime.difference(checkInTime).inHours;
    final minutes = checkOutTime.difference(checkInTime).inMinutes;
    final totalWorkingHours = '$hours.${(minutes - (hours * 60))} hrs';
    print(totalWorkingHours);

    // var format = DateFormat("HH:mm");
    // // var format =  DateFormat.yMEd().add_jms();
    // var start = format.parse(startTime);
    // var end = format.parse(endTime);
    //
    // if (start.isAfter(end)) {
    //   end = end.add(const Duration(days: 1));
    //   Duration diff = end.difference(start);
    //   final hours = diff.inHours;
    //   final minutes = diff.inMinutes % 60;
    //
    //   return ('$hours.$minutes Hours');
    // }
  }

  /// ===================Custom Flutter Toast============================== ///
  static showToast(String value) {
    Fluttertoast.showToast(
        msg: value,
        textColor: const Color(0xFFffffff),
        backgroundColor: Colors.red);
  }

  /// ===================Custom Flutter Toast============================== ///

  /// ===================Custom Flutter Toast============================== ///

  /// ===================Custom Flutter Toast============================== ///

  /// ================================================= ///

  static DateTime convertTimeStampTODateTime(var date) {
    var formatted = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return formatted;
  }

  /// Method to show *** Snack Bar ***
  static showSnackBar({required BuildContext context, required String msg}) {
    final bar = SnackBar(
      behavior: SnackBarBehavior.floating,
      // duration: const Duration(seconds: 3),
      content: Text(
        msg,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(Constants.lightgreen),
    );
    bar.show(context);

    ///
  }

  /// ==================== Calculate total amount =======================TimeSheetPreview ///

  static calculateTotalAmount(double amount1, double amount2) {
    final totalAmount = amount1 * amount2;
    return totalAmount;

    /// $iCostPerHour = 9.500;
    /// $timespent = '08:15:00';
    /// $timeparts=explode(':',$timespent);
    /// $pay=$timeparts[0]*$iCostPerHour+$timeparts[1]/60*$iCostPerHour;
    /// echo $pay;
  }

  /// ==================== Calculate total amount =======================TimeSheetPreview ///

  /// Method to Get the Current Day *** DATE ***
  static getCurrentDate(BuildContext context) {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    // var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    var finalDate = Provider.of<DataProviders>(context).finalDate =
        formattedDate.toString();
    return finalDate;
  }

  /// Open link in the *** Browser ***
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<bool> onWillPopFunc(
      {required BuildContext context, required dynamic className}) {
    DateTime? currentBackPressTime;
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => className,
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  /// Disabale  emojis from  *** textField ***
  static var disableEmojiFromTextField = FilteringTextInputFormatter.deny(RegExp(
      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));
}

class ImageSelection extends ChangeNotifier {
  File? image;
  Future getImagefromcamera() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(selectedImage!.path);
    notifyListeners();
  }

  Future getImagefromGallery() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(selectedImage!.path);
    notifyListeners();
  }

//===================================Start
//   gotoScreen(BuildContext context, {required dynamic className}) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (BuildContext context) => className));
//   }

//   static popScopeFunc() {

  // }
// DateTime? currentBackPressTime;
// Future<bool> onWillPop(BuildContext context) {
//   DateTime now = DateTime.now();
//   if (currentBackPressTime == null ||
//       now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
//     currentBackPressTime = now;
//     Navigator.pushReplacement(
//       context,
//       CupertinoPageRoute(
//         builder: (context) => const MenuScreen(),
//       ),
//     );
//     return Future.value(false);
//   }
//   return Future.value(true);
// }
//===================================END

}
