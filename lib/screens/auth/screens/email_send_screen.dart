import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ole_app/screens/auth/screens/signin_screen.dart';
import '../../../custom_widgets/colored_button.dart';
import '../../../utils/constant.dart';
import '../../../utils/helper.dart';
import '../../../utils/string_resource.dart';

class EmailSendScreen extends StatelessWidget {
  const EmailSendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //===================================Start
    // DateTime? currentBackPressTime;
    // Future<bool> onWillPop() {
    //   DateTime now = DateTime.now();
    //   if (currentBackPressTime == null ||
    //       now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
    //     currentBackPressTime = now;
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const SignInScreen(),
    //         ));
    //     return Future.value(false);
    //   }
    //   return Future.value(true);
    // }
    //===================================END

    return OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () => Helper.onWillPopFunc(
            context: context,
            className: const SignInScreen(),
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: 1.sh,
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie_files/pleaseWait.json',
                          fit: BoxFit.contain,
                          width: 182.w,
                          height: 182.h,
                        ),
                        SizedBox(
                          height: 37.h,
                        ),
                        Text(
                          StringResource.emailSentTxt,
                          style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? 23.sp
                                  : 35.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(StringResource.emailSentTxtSubtext1,
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 17.sp
                                    : 30.sp)),
                        Text(StringResource.emailSentTxtSubtext2,
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 17.sp
                                    : 30.sp)),
                        SizedBox(
                          height:
                              orientation == Orientation.portrait ? 24.h : 50.h,
                        ),
                        colored_Button(160.w, StringResource.goBackBtnTxt, () {
                          // Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ));
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
