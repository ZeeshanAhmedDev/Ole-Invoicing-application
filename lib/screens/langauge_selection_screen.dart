import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ole_app/utils/string_resource.dart';
import '../translations/locale_keys.g.dart';
import 'invoice_screen.dart';
import 'menu_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

pushToMenuScreen(BuildContext context) {
  Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const MenuScreen(),
      ));
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  void initState() {
    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      if (kDebugMode) {
        print("token is $token");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: StringResource.pressAgainToClose,
      child: Scaffold(
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg_images/langaugeSelectionPicSvg.svg',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  LocaleKeys.ole_invoicing_text.tr(),
                  style: TextStyle(
                      fontSize: 29.84.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  "&" + LocaleKeys.timesheet_menuHeader_text.tr(),
                  style: TextStyle(
                      fontSize: 29.84.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 32.h,
                ),
                GestureDetector(
                  onTap: () {
                    context.setLocale(const Locale('en', 'US'));
                    pushToMenuScreen(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 338.w,
                    height: 67.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff6FC4DB)),
                        color: const Color(0xff6FC4DB).withOpacity(0.24),
                        borderRadius: BorderRadius.circular(13.r)),
                    child: Text(LocaleKeys.english_txt.tr(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 16.68.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                GestureDetector(
                  onTap: () async {
                    context.setLocale(const Locale('es', 'ES'));
                    pushToMenuScreen(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 338.w,
                    height: 67.h,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff9e7acbe0).withOpacity(0.62),
                            blurRadius: 32,
                            offset: Offset(0, 8),
                          ),
                        ],
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xffAEE9F7),
                            Color(0xff6FC4DB)
                          ], // red to yellow
                        ),
                        border: Border.all(color: const Color(0xff6FC4DB)),
                        borderRadius: BorderRadius.circular(13.r)),
                    child: Text(LocaleKeys.spanish_txt.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.68.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  height: 150.h,
                ),
                TextButton(
                  onPressed: () {
                    getFcm();
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              InvoicesScreen("Previous Invoices"),
                        ));
                  },
                  child: Text(
                    LocaleKeys.previous_invoice_txt.tr(),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: const Color(0xff61ACBE),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.68.sp),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getFcm() async {
    String str = '';

    String? token = await FirebaseMessaging.instance.getToken();
    str = token!;
    if (kDebugMode) {
      print('Token  ' + str);
    }
  }
}
