import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ole_app/screens/invoice_screen.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import 'package:ole_app/utils/constant.dart';
import 'package:ole_app/utils/helper.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/textFeild.dart';
import 'Provider.dart';
import 'custom_widgets/Container_btn_with_gradient.dart';
import 'custom_widgets/appbar.dart';
import 'models/add_client_model.dart';
import 'utils/controllers.dart';

class AddClient extends StatefulWidget {
  final String appBarName;

  const AddClient({Key? key, required this.appBarName}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // ControllersTextFields.instance.clientNameAddClientController.dispose();
    // ControllersTextFields.instance.clientAddressAddClientController.dispose();
    // ControllersTextFields.instance.clientPhoneNoAddClientController.dispose();
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
            className: InvoicesScreen(LocaleKeys.clients_txt.tr()),
          ),
          child: Scaffold(
            appBar: CustomAppBar(
                title: widget.appBarName,
                fun: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          InvoicesScreen(LocaleKeys.clients_txt.tr()),
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
                          LocaleKeys.client_name_txt.tr(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.client_name_txt.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields
                                .instance.clientNameAddClientController.text
                                .trimLeft()
                                .isEmpty) {
                              // return StringResource.enterValidClientNameMessage;
                              return LocaleKeys
                                  .pleaseEnterAClientNameValidation_Msg
                                  .tr();
                            }
                            if ((!Constants.regExpForOnlyAlphabetsWithSpace
                                .hasMatch(ControllersTextFields.instance
                                    .clientNameAddClientController.text))) {
                              return LocaleKeys.pleaseEnterOnlyAlphabets_txt
                                  .tr();
                            }
                            return null;
                          },

                          controller: ControllersTextFields
                              .instance.clientNameAddClientController,
                          maximumLength: 60,
                          keyboardType: TextInputType.name,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.clientAddress.tr(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.clientAddress.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields
                                .instance.clientAddressAddClientController.text
                                .trimLeft()
                                .isEmpty) {
                              return LocaleKeys
                                  .pleaseEnterAnAddressValidation_Msg
                                  .tr();
                            }

                            return null;
                          },
                          controller: ControllersTextFields
                              .instance.clientAddressAddClientController,

                          maximumLength: 60,
                          keyboardType: TextInputType.streetAddress,
                          // focusNode: Constants.focusNodeEmailLogin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          LocaleKeys.clientPhone.tr(),
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                          LocaleKeys.clientPhone.tr(),
                          368.w,
                          validatorr: (value) {
                            if (ControllersTextFields
                                .instance.clientPhoneNoAddClientController.text
                                .trimLeft()
                                .isEmpty) {
                              return LocaleKeys
                                  .pleaseEnterClientPhoneNumberValidation_Msg
                                  .tr();
                            }

                            return null;
                          },
                          controller: ControllersTextFields
                              .instance.clientPhoneNoAddClientController,
                          maximumLength: 11,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 200.h,
                        ),
                        CustomContainerButton(
                          text: LocaleKeys.AddClient.tr(),
                          onPressed: () {
                            // Helper.selectedItems = .toString();

                            final user = AddClientInformation(
                              clientName: ControllersTextFields
                                  .instance.clientNameAddClientController.text,
                              clientAddress: ControllersTextFields.instance
                                  .clientAddressAddClientController.text,
                              phone: ControllersTextFields.instance
                                  .clientPhoneNoAddClientController.text,
                              dateTime: DateTime.now(),
                            );

                            if (_formKey.currentState!.validate()) {
                              addClient(user);
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
                                      LocaleKeys.clients_txt.tr()),
                                ));
                            clearTextFields();
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

  Future addClient(AddClientInformation user) async {
    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(true);

    /// Reference to document
    final docUser = FirebaseFirestore.instance.collection('addClient').doc();
    user.id = docUser.id;

    final json = user.toJson();

    /// Create document and write data to Firebase
    await docUser.set(json);

    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(false);

    log(json.toString());
    Helper.showSnackBar(
        msg: LocaleKeys.clientAddedSuccessfully_text.tr(), context: context);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => InvoicesScreen('Clients'),
        ));
    clearTextFields();
  }

  clearTextFields() {
    ControllersTextFields.instance.clientNameAddClientController.clear();

    ControllersTextFields.instance.clientAddressAddClientController.clear();

    ControllersTextFields.instance.clientPhoneNoAddClientController.clear();
  }
}
