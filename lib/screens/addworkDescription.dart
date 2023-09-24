import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/edit_workDescription.dart';
import 'package:ole_app/utils/controllers.dart';
import 'package:provider/provider.dart';
import '../Provider.dart';
import '../custom_widgets/Container_btn_with_gradient.dart';
import '../custom_widgets/appbar.dart';
import '../custom_widgets/textFeild.dart';
import '../models/AddWorkDescriptionModel.dart';
import '../translations/locale_keys.g.dart';
import '../utils/constant.dart';
import '../utils/helper.dart';
import 'justShowTableOFWorkDescriptionScreen.dart';

class AddWorkDescriptionScreen extends StatefulWidget {
  var appBarName;
  AddWorkDescriptionScreen(
    this.appBarName, {
    Key? key,
  }) : super(key: key);

  @override
  _AddWorkDescriptionScreenState createState() =>
      _AddWorkDescriptionScreenState();
}

class _AddWorkDescriptionScreenState extends State<AddWorkDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // ControllersTextFields.instance.clientNameAddDescriptionController.dispose();
    // ControllersTextFields.instance.costCodeAddDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<DataProviders>(context).showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: Color(Constants.lightgreen),
        ),
        child: WillPopScope(
          onWillPop: () => Helper.onWillPopFunc(
            context: context,
            className: const EditWorkDescription(),
          ),
          child: Scaffold(
            appBar: CustomAppBar(
                title: widget.appBarName ?? '',
                fun: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EditWorkDescription(),
                    )),
                elevation: 0),
            body: Container(
              height: 1.sh,
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          LocaleKeys.work_description_txt.tr(),
                          // StringResource.SignIn,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.work_description_txt.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields.instance
                                .clientNameAddDescriptionController.text
                                .trimLeft()
                                .isEmpty) {
                              // return StringResource.enterWorkDescriptionText;
                              return LocaleKeys
                                  .pleaseEnterWorkDescriValidationMsg_text
                                  .tr();
                            }
                            // if ((!Constants.regExpForEmail
                            //     .hasMatch(companyControllerLogin.text))) {
                            //   return StringResource
                            //       .enterValidCompanyNameMessage;
                            // }
                            return null;
                          },
                          controller: ControllersTextFields
                              .instance.clientNameAddDescriptionController,
                          maximumLength: 60,
                          keyboardType: TextInputType.name,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.costCode_txt.tr(),
                          // StringResource.SignIn,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.costCode_txt.tr(),
                          // StringResource.enterAddress,
                          368.w,
                          validatorr: (value) {
                            if (value == null || value.isEmpty) {
                              // return StringResource.enterCostCodeErrorMsg;
                              return LocaleKeys
                                  .pleaseEnterCostCodeValidationMsg_text
                                  .tr();
                            }

                            // if ((!Constants.regExpForEmail
                            //     .hasMatch(userNameControllerLogin.text))) {
                            //   return StringResource.enterValidEmailMessage;
                            // }
                            return null;
                          },
                          controller: ControllersTextFields
                              .instance.costCodeAddDescriptionController,
                          maximumLength: 60,
                          keyboardType: TextInputType.number,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 380.h,
                        ),
                        CustomContainerButton(
                          text: LocaleKeys.add_work_description_txt.tr(),
                          onPressed: () {
                            final workDescription = ControllersTextFields
                                .instance
                                .clientNameAddDescriptionController
                                .text;
                            final costCode = ControllersTextFields
                                .instance.costCodeAddDescriptionController.text;

                            final user = AddWorkDescriptionModel(
                              workDescription: workDescription,
                              costCode: costCode,
                              dateTime: DateTime.now(),
                            );
                            if (_formKey.currentState!.validate()) {
                              addWorkDescription(user);
                            }
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomContainerButton(
                          text: LocaleKeys.cancel_txt.tr(),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const EditWorkDescription(),
                                ));
                          },
                          isActive: false,
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
  }

  Future addWorkDescription(AddWorkDescriptionModel user) async {
    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(true);

    /// Reference to document
    final docUser =
        FirebaseFirestore.instance.collection('addWorkDescription').doc();
    user.id = docUser.id;

    final json = user.toJson();

    /// Create document and write data to Firebase
    await docUser.set(json);

    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(false);

    log(json.toString());
    Helper.showSnackBar(
        msg: LocaleKeys.workDescriptionAddedSuccessfully_txt.tr(),
        context: context);

    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const JustShowTableOFWorkDescriptionScreen(),
        )).then((value) {
      ControllersTextFields.instance.clientNameAddDescriptionController.clear();
      ControllersTextFields.instance.costCodeAddDescriptionController.clear();
    });
  }
}
