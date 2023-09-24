import 'dart:developer';
import 'dart:convert' as convert;
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/auth/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../../Provider.dart';
import '../../../custom_widgets/colored_button.dart';
import '../../../custom_widgets/textFeild.dart';
import '../../../utils/constant.dart';
import '../../../utils/string_resource.dart';
import '../../langauge_selection_screen.dart';
import 'forgot_password_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // ControllersTextFieldsClass _controllersTextFieldsClass =
  //     ControllersTextFieldsClass();

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
                          StringResource.SignIn,
                          // StringResource.SignIn,
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        textField(
                          StringResource.companyName,
                          368.w,
                          validatorr: (value) {
                            if (value.isEmpty) {
                              return StringResource
                                  .enterValidCompanyNameMessage;
                            }
                            // if ((!Constants.regExpForEmail
                            //     .hasMatch(companyControllerLogin.text))) {
                            //   return StringResource
                            //       .enterValidCompanyNameMessage;
                            // }
                            return null;
                          },
                          controller: companyControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.name,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.userName,
                          368.w,
                          validatorr: (value) {
                            if (value.isEmpty) {
                              return StringResource.enterValidUserNameMessage;
                            }

                            // if ((!Constants.regExpForEmail
                            //     .hasMatch(userNameControllerLogin.text))) {
                            //   return StringResource.enterValidEmailMessage;
                            // }
                            return null;
                          },
                          controller: userNameControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.name,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        textField(
                          StringResource.password,
                          368.w,
                          validatorr: (value) {
                            //   if ((!Constants.regExpForpas
                            //       .hasMatch(companyControllerLogin.text))) {
                            //     return StringResource.enterValidEmailMessage;
                            //   }
                            //   return null;
                            // },

                            if (value.isEmpty) {
                              return StringResource
                                  .enterValidPasswordMessageIsEmpty;
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
                          StringResource.useWorkCategory,
                          368.w,
                          validatorr: (value) {
                            if (value.isEmpty) {
                              return StringResource
                                  .enterValidUseWorkCategoryMessage;
                            }

                            // if ((!Constants.regExpForEmail.hasMatch(
                            //     useWorkCategoryControllerLogin.text))) {
                            //   return StringResource.enterValidEmailMessage;
                            // }
                            return null;
                          },
                          controller: useWorkCategoryControllerLogin,
                          maximumLength: 60,
                          keyboardType: TextInputType.text,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        colored_Button(160.w, 'Sign in', () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LanguageSelectionScreen(),
                                ));
                          }
                        }),
                        SizedBox(
                          height: 32.h,
                        ),
                        Text(StringResource.DoNot_Have_an_Account,
                            style: TextStyle(fontSize: 16.4.sp)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ));
                            }),
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Text(
                                StringResource.SignUp,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18.98.sp,
                                  color: Color(Constants.lightgreen),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: (() {
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const SignUpScreen(),
                        //         ));
                        //   }),
                        //   child: Padding(
                        //     padding: EdgeInsets.all(10.h),
                        //     child: Text(
                        //       StringResource.SignUp,
                        //       style: TextStyle(
                        //         decoration: TextDecoration.underline,
                        //         fontSize: 18.98.sp,
                        //         color: Color(Constants.lightgreen),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: (() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ));
                              }),
                              child: Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Text(
                                  StringResource.forgotPassword,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(Constants.lightgreen),
                                    fontSize: 18.98.sp,
                                  ),
                                ),
                              )),
                        ),
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

  /// ------------------------- login API ----------------------------
  // void callLoginApi() async {
  //   Provider.of<DataProviderss>(context, listen: false)
  //       .isTrueOrFalseFunctionProgressHUD(true);
  //   // setState(() {
  //   //   Helper.showSpinner = true;
  //   // });
  //   var url = Uri.parse(Api.loginPath);
  //
  //   final response = await http.post(
  //     url,
  //     body: {
  //       'email': _controllersTextFieldsClass.emailLoginController.text,
  //       'password': _controllersTextFieldsClass.passwordLoginController.text,
  //     },
  //   );
  //
  //   try {
  //     var jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     if (response.statusCode == 200) {
  //       //----------------------------------
  //       _controllersTextFieldsClass.emailLoginController.clear();
  //       _controllersTextFieldsClass.passwordLoginController.clear();
  //
  //       ///Saving TOKEN Value in Shared Preferences =========================
  //       MySharedPreferences.instance
  //           .setStringValue('token', jsonResponse['data']['token']);
  //       MySharedPreferences.instance.setStringValue(
  //           'companyId', jsonResponse['data']['user']['company_id']);
  //
  //       // ///Saving Email Value in Shared Preferences =========================
  //       MySharedPreferences.instance
  //           .setStringValue('email', jsonResponse['data']['user']['email']);
  //
  //       MySharedPreferences.instance
  //           .setStringValue('userName', jsonResponse['data']['user']['name']);
  //
  //       log("--------" + response.body);
  //
  //       // setState(() {
  //       //   Helper.showSpinner = false;
  //       // });
  //       Provider.of<DataProviderss>(context, listen: false)
  //           .isTrueOrFalseFunctionProgressHUD(false);
  //
  //       Navigator.of(context)
  //           .pushReplacement(
  //               // MaterialPageRoute(builder: (context) => const customerView()))
  //               MaterialPageRoute(
  //                   builder: (context) => const TakeFeedbackIDScreen()))
  //           .then((value) => setState(() {
  //                 // Helper.showSpinner = false;
  //                 Provider.of<DataProviderss>(context, listen: false)
  //                     .isTrueOrFalseFunctionProgressHUD(false);
  //               }));
  //     } else if (response.statusCode == 403) {
  //       log("Error ${response.body}");
  //       log("Status code ${response.statusCode}");
  //       String error = jsonResponse['message'];
  //       Helper.ToastMessage(context: context, descMessage: error);
  //
  //       Provider.of<DataProviderss>(context, listen: false)
  //           .isTrueOrFalseFunctionProgressHUD(false);
  //       // setState(() {
  //       //   Helper.showSpinner = false;
  //       // });
  //     } else {
  //       log("Error ${response.body}");
  //       log("Status code ${response.statusCode}");
  //       String error = jsonResponse['message'];
  //       Helper.ToastMessage(context: context, descMessage: error);
  //       // setState(() {
  //       //   Helper.showSpinner = false;
  //       // });
  //       Provider.of<DataProviderss>(context, listen: false)
  //           .isTrueOrFalseFunctionProgressHUD(false);
  //     }
  //   } on Exception catch (e) {
  //     // setState(() {
  //     //   Helper.showSpinner = false;
  //     // });
  //
  //     Provider.of<DataProviderss>(context, listen: false)
  //         .isTrueOrFalseFunctionProgressHUD(false);
  //   }
  // }
}
