import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/OnBoardingScreen.dart';
import 'package:ole_app/screens/langauge_selection_screen.dart';
import 'package:ole_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  //====================================================================
  Future checkFirstSeen() async {
    Timer(const Duration(seconds: Constants.seconds), () async {
      final pref = await SharedPreferences.getInstance();
      final showHome = pref.getBool('showHome') ?? false;
      showHome
          ? Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                  builder: (context) => const LanguageSelectionScreen()),
            )
          //   .then((value) {
          //   setState(() {});
          // })
          : Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                  builder: (context) => const LanguageSelectionScreen()),
            );
      //   .then(
      //   (value) {
      //     setState(() {});
      //   },
      // );
    });
  }
  //====================================================================

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(Constants.kMainLogoSvg,
                fit: BoxFit.cover, width: 245.w, height: 249.63.h
                // scale: 0.8,
                ),
          ),
        ),
      ),
    );
  }
}
