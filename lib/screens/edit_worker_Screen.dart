import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/invoice_screen.dart';
import 'package:provider/provider.dart';
import '../Provider.dart';
import '../custom_widgets/Container_btn_with_gradient.dart';
import '../custom_widgets/appbar.dart';
import '../custom_widgets/textFeild.dart';
import '../models/edit_worker_model.dart';
import '../translations/locale_keys.g.dart';
import '../utils/constant.dart';
import '../utils/controllers.dart';
import '../utils/helper.dart';
import '../utils/string_resource.dart';

class EditWorkerScreen extends StatefulWidget {
  var appBarName;
  EditWorkerScreen(
    this.appBarName, {
    Key? key,
  }) : super(key: key);

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditWorkerScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
            className: InvoicesScreen(LocaleKeys.workers_txt.tr()),
          ),
          child: Scaffold(
            appBar: CustomAppBar(
                title: widget.appBarName ?? '',
                fun: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          InvoicesScreen(LocaleKeys.workers_txt.tr()),
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
                          LocaleKeys.workerName.tr(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.workerName.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields
                                .instance.workerClientName.text
                                .trimLeft()
                                .isEmpty) {
                              return LocaleKeys
                                  .pleaseEnterWorkerNameValidation_Msg
                                  .tr();
                            }

                            if ((!Constants.regExpForOnlyAlphabetsWithSpace
                                .hasMatch(ControllersTextFields
                                    .instance.workerClientName.text))) {
                              return LocaleKeys.pleaseEnterOnlyAlphabets_txt
                                  .tr();
                            }
                            return null;
                          },
                          controller:
                              ControllersTextFields.instance.workerClientName,
                          maximumLength: 60,
                          keyboardType: TextInputType.name,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.workerAddress.tr(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.workerAddress.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields
                                .instance.workerClientAddress.text
                                .trimLeft()
                                .isEmpty) {
                              return LocaleKeys
                                  .pleaseEnterAnAddressValidation_Msg
                                  .tr();
                            }
                            return null;
                          },
                          controller: ControllersTextFields
                              .instance.workerClientAddress,
                          maximumLength: 60,
                          keyboardType: TextInputType.streetAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.workerPhone.tr(),
                          // StringResource.SignIn,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.workerPhone.tr(),
                          368.w,
                          validatorr: (value) {
                            if (value.isEmpty) {
                              return LocaleKeys
                                  .pleaseEnterWorkerPNoValidation_Msg
                                  .tr();
                            }
                            return null;
                          },
                          controller:
                              ControllersTextFields.instance.workerClientPhone,
                          maximumLength: 11,
                          keyboardType: TextInputType.phone,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 230.h,
                        ),
                        CustomContainerButton(
                          text: LocaleKeys.save_txt.tr(),
                          onPressed: () {
                            final user = EditWorkerModel(
                              dateTime: DateTime.now(),
                              workerClientName: ControllersTextFields
                                  .instance.workerClientName.text,
                              workerClientAddress: ControllersTextFields
                                  .instance.workerClientAddress.text,
                              phone: ControllersTextFields
                                  .instance.workerClientPhone.text,
                            );

                            if (_formKey.currentState!.validate()) {
                              editWorkers(user);
                            }
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomContainerButton(
                          text: LocaleKeys.discard_txt.tr(),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => InvoicesScreen(
                                    LocaleKeys.workers_txt.tr(),
                                  ),
                                ));
                            // Navigator.pop(context);
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

  Future editWorkers(EditWorkerModel user) async {
    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(true);

    /// Reference to document
    final docUser = FirebaseFirestore.instance.collection('editWorker').doc();
    user.id = docUser.id;

    final json = user.toJson();

    /// Create document and write data to Firebase
    await docUser.set(json);

    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(false);

    log(json.toString());
    Helper.showSnackBar(
        msg: LocaleKeys.workerAddedSuccessfully_text.tr(), context: context);
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => InvoicesScreen('Workers'),
          ));
    });
    clearTextFields();
  }

  clearTextFields() {
    ControllersTextFields.instance.workerClientName.clear();
    ControllersTextFields.instance.workerClientAddress.clear();
    ControllersTextFields.instance.workerClientPhone.clear();
  }
}
