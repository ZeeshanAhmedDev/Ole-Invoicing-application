import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/langauge_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom_widgets/buildPage.dart';
import '../utils/helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controllerPageView = PageController();

  @override
  void dispose() {
    _controllerPageView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80.h, top: 8.h),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controllerPageView,
          onPageChanged: (index) {
            setState(() {
              Helper.isLastPage = index == 2;
            });
          },
          children: [
            BuildPageOfOnBoard(
                controllerPageView: _controllerPageView,
                imageUrl: 'assets/svg_images/onBoard1.svg',
                title: 'Easy Invoicing',
                subTitle: 'Easily create an invoice in English and Hispanic'),
            BuildPageOfOnBoard(
                controllerPageView: _controllerPageView,
                imageUrl: 'assets/svg_images/onBoard2.svg',
                title: 'Get Things Done Fast',
                subTitle: 'Edit your workers and clients easily'),
            BuildPageOfOnBoard(
                controllerPageView: _controllerPageView,
                imageUrl: 'assets/svg_images/onBoard3.svg',
                title: 'Affordable Plans',
                subTitle: 'Select the best suitable plan for yourself.'),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: Helper.isLastPage ? false : true,
              child: TextButton(
                  onPressed: () {
                    _controllerPageView.jumpToPage(2);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff71C9DD)),
                  )),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20.5.r),
              onTap: !Helper.isLastPage
                  ? () {
                      _controllerPageView.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  : () async {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            // builder: (context) => const SignInScreen(),
                            builder: (context) =>
                                const LanguageSelectionScreen(),
                          ));
                      final pref = await SharedPreferences.getInstance();
                      pref.setBool('showHome', true);
                    },
              child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 93.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff71C9DD),
                    borderRadius: BorderRadius.circular(17.5.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.h,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
