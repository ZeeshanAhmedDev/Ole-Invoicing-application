import 'dart:convert' as convert;
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/auth/screens/signin_screen.dart';
import 'package:ole_app/screens/auth/screens/wait_screen.dart';
import 'package:provider/provider.dart';

import '../../../Provider.dart';
import '../../../custom_widgets/colored_button.dart';
import '../../../custom_widgets/textFeild.dart';
import '../../../utils/constant.dart';
import '../../../utils/string_resource.dart';
import 'forgot_password_Screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final companyControllerLogin = TextEditingController();
  final userNameControllerLogin = TextEditingController();
  final passwordControllerLogin = TextEditingController();
  final useWorkCategoryControllerLogin = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    companyControllerLogin.dispose();
    userNameControllerLogin.dispose();
    passwordControllerLogin.dispose();
    useWorkCategoryControllerLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return OrientationBuilder(builder: (context, orientation) {
    return Form(
      key: _formKey,
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<DataProviders>(context).showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: Color(Constants.lightgreen),
        ),
        child: DoubleBack(
          // message: 'press two time to close',
          message: StringResource.pressAgainToClose,
          child: Scaffold(
            // resizeToAvoidBottomInset: true,
            body: Container(
              height: 1.sh,
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 98.h),
                        Image.asset(
                          Constants.kMainLogoSvg,
                          fit: BoxFit.cover,
                          height: 178.h,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          StringResource.SignUp,
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        textField(
                          StringResource.userName,
                          368.w,
                          validatorr: (value) {
                            if ((!Constants.regExpForEmail
                                .hasMatch(companyControllerLogin.text))) {
                              return StringResource.enterValidUserNameMessage;
                            }
                            return null;
                          },
                          controller: companyControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.organizationName,
                          368.w,
                          validatorr: (value) {
                            if ((!Constants.regExpForEmail
                                .hasMatch(userNameControllerLogin.text))) {
                              return StringResource.enterValidEmailMessage;
                            }
                            return null;
                          },
                          controller: userNameControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.contactNoTxtHint,
                          368.w,
                          validatorr: (value) {
                            if ((!Constants.regExpForEmail
                                .hasMatch(companyControllerLogin.text))) {
                              return StringResource.enterValidEmailMessage;
                            }
                            return null;
                          },
                          controller: passwordControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.Email_Address,
                          368.w,
                          validatorr: (value) {
                            if ((!Constants.regExpForEmail.hasMatch(
                                useWorkCategoryControllerLogin.text))) {
                              return StringResource.enterValidEmailMessage;
                            }
                            return null;
                          },
                          controller: useWorkCategoryControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.industrySignUpDropDownHintText,
                          368.w,
                          validatorr: (value) {
                            if ((!Constants.regExpForEmail.hasMatch(
                                useWorkCategoryControllerLogin.text))) {
                              return StringResource.enterValidEmailMessage;
                            }
                            return null;
                          },
                          controller: useWorkCategoryControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.emailAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        colored_Button(160.w, StringResource.SignUp, () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const WaitScreen()));
                          }
                        }),
                        SizedBox(
                          height: 70.h,
                        ),
                        Text(StringResource.Already_Have_an_Account,
                            style: TextStyle(
                                fontSize: 17.sp, color: Color(0xFF282828))),
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
                                child: Text(StringResource.SignInSmall,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(Constants.lightgreen),
                                        fontSize: 18.sp)),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // });
  }
}
