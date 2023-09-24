import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/auth/screens/signin_screen.dart';
import '../../../custom_widgets/colored_button.dart';
import '../../../custom_widgets/textFeild.dart';
import '../../../utils/constant.dart';
import '../../../utils/helper.dart';
import '../../../utils/string_resource.dart';
import 'package:http/http.dart' as http;

import 'email_send_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailForgotPasswordController = TextEditingController();

  //===================================Start
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  //===================================END
  @override
  void dispose() {
    emailForgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // return OrientationBuilder(builder: (context, orientation) {
    return Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: Helper.showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Color(Constants.lightgreen),
          ),
          child: WillPopScope(
            onWillPop: () => onWillPop(),
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 180.h,
                          ),
                          Image.asset(
                            Constants.kMainLogoSvg,
                            fit: BoxFit.cover,
                            height: 178.h,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            StringResource.forgotPassword.replaceAll("?", ""),
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(StringResource.enterYourEmailForgotText1,
                              style: TextStyle(
                                  fontSize: 17.sp, color: Color(0xFF747474))),
                          Text(StringResource.enterYourEmailForgotText2,
                              style: TextStyle(
                                  fontSize: 17.sp, color: Color(0xFF747474))),
                          SizedBox(
                            height: 20.h,
                          ),
                          textField(
                            StringResource.Email_Address,
                            368.w,
                            validatorr: (value) {
                              if ((!Constants.regExpForEmail.hasMatch(
                                  emailForgotPasswordController.text))) {
                                return StringResource
                                    .enterValidCompanyNameMessage;
                              }
                              return null;
                            },
                            controller: emailForgotPasswordController,
                            maximumLength: 60,
                            keyboardType: TextInputType.emailAddress,
                            // focusNode: Constants.focusNodeEmailLogin,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          colored_Button(160.w, StringResource.sendEmailBtnTxt,
                              () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmailSendScreen(),
                                ));
                          }),
                          SizedBox(
                            height: 27.h,
                          ),
                          SizedBox(
                            height: 140.h,
                          ),
                          Text(StringResource.Already_Have_an_Account,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: const Color(0xFF282828))),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: (() {
                                  // Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen(),
                                      ));
                                }),
                                child: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: Text(StringResource.SignIn,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(Constants.lightgreen),
                                          fontSize: 18.sp)),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // void forgotApi(var email) async {
  //   var response;
  //   setState(() {
  //     Helper.showSpinner = true;
  //   });
  //
  //   Map<String, String> myBody = {'email': email};
  //   Map<String, String> myHeader = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //
  //   response = await http.post(Uri.parse(Api.forgotPassword), body: myBody);
  //
  //   try {
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         Helper.showSpinner = false;
  //       });
  //       var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //       final responseString = response.body;
  //       // forgotPasswordModelFromJson(responseString);
  //       log('=======>' + responseString);
  //
  //       if (jsonResponse['status'] ==
  //           "We can't find a user with that email address.") {
  //         Fluttertoast.showToast(
  //             msg: "We can't find a user with that email address.",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.TOP,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       } else if (jsonResponse['status'] == 'Please wait before retrying.') {
  //         Fluttertoast.showToast(
  //             msg: "Please wait before retrying.",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.TOP,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       } else {
  //         log('====else part of 200 ===>' + response.body);
  //         Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => const emailScreen()));
  //       }
  //     } else if (response.statusCode == 403) {
  //       Fluttertoast.showToast(
  //           msg: "email or password is incorrect",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       setState(() {
  //         Helper.showSpinner = false;
  //       });
  //       log(" 403 error ${response.statusCode}");
  //     } else {
  //       setState(() {
  //         Helper.showSpinner = false;
  //       });
  //       log("${response.statusCode}");
  //       log('===other====>' + response.body);
  //     }
  //   } on Exception catch (e) {
  //     log('$e');
  //     setState(() {
  //       Helper.showSpinner = false;
  //     });
  //   }
  // }
}
