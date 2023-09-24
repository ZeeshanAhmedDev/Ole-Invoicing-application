import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ole_app/screens/auth/screens/signin_screen.dart';

import '../../../custom_widgets/colored_button.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: 1.sh,
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height:
                      //       orientation == Orientation.portrait ? 160.h : 20.h,
                      // ),
                      Lottie.asset(
                        'assets/lottie_files/pleaseWait.json',
                        fit: BoxFit.contain,
                        width: 182.w,
                        height: 182.h,
                      ),
                      // Image.asset("assets/images/office.gif",
                      //    width: width * 0.8),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(
                        "Please Wait",
                        style: TextStyle(
                            fontSize: 23.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Your request has been received",
                          style: TextStyle(fontSize: 17.sp)),
                      Text(" successfully. You will be contacted",
                          style: TextStyle(fontSize: 17.sp)),
                      Text(" for further proceedings.",
                          style: TextStyle(fontSize: 17.sp)),
                      SizedBox(
                        height: 24.h,
                      ),
                      colored_Button(160.w, 'Go Back', () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
