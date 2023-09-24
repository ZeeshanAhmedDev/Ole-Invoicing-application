import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/invoice_screen.dart';
import '../custom_widgets/Container_btn_with_gradient.dart';
import '../custom_widgets/appbar.dart';
import '../custom_widgets/textFeild.dart';
import '../utils/constant.dart';
import '../utils/helper.dart';
import '../utils/string_resource.dart';

class EditClientScreen extends StatefulWidget {
  var appBarName;
  final String clientName;
  final String phoneNo;
  final String clientAddress;
  EditClientScreen(
    this.appBarName, {
    Key? key,
    required this.clientName,
    required this.phoneNo,
    required this.clientAddress,
  }) : super(key: key);

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final clientNameController = TextEditingController();
  final clientAddressController = TextEditingController();
  final clientPhoneNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    clientNameController.dispose();
    clientAddressController.dispose();
    clientPhoneNoController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    clientNameController.text = widget.clientName;
    clientAddressController.text = widget.clientAddress;
    clientPhoneNoController.text = widget.phoneNo;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: CustomAppBar(
            title: widget.appBarName ?? '',
            fun: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => InvoicesScreen("Clients"),
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
                      "Client Name",
                      // StringResource.SignIn,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    textField(
                      StringResource.clientName,
                      368.w,
                      validatorr: (value) {
                        if (value.isEmpty) {
                          return StringResource.enterValidClientNameMessage;
                        }
                        // if ((!Constants.regExpForEmail
                        //     .hasMatch(companyControllerLogin.text))) {
                        //   return StringResource
                        //       .enterValidCompanyNameMessage;
                        // }
                        return null;
                      },
                      controller: clientNameController,
                      maximumLength: 60,
                      keyboardType: TextInputType.name,
                      // focusNode: Constants.focusNodeEmailLogin,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Address",
                      // StringResource.SignIn,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    textField(
                      StringResource.enterAddress,
                      368.w,
                      validatorr: (value) {
                        if (value.isEmpty) {
                          return StringResource.enterValidEmailMessage;
                        } else if ((!Constants.regExpForEmail
                            .hasMatch(clientAddressController.text))) {
                          return StringResource.enterValidEmailMessage;
                        }

                        return null;
                      },
                      controller: clientAddressController,
                      maximumLength: 60,
                      keyboardType: TextInputType.streetAddress,
                      // focusNode: Constants.focusNodeEmailLogin,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Client Phone",
                      // StringResource.SignIn,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    textField(
                      StringResource.clientPhone,
                      368.w,
                      validatorr: (value) {
                        if (value.isEmpty) {
                          return StringResource.enterClientPhoneMessage;
                        }

                        // if ((!Constants.regExpForEmail
                        //     .hasMatch(userNameControllerLogin.text))) {
                        //   return StringResource.enterValidEmailMessage;
                        // }
                        return null;
                      },
                      controller: clientPhoneNoController,
                      maximumLength: 60,
                      keyboardType: TextInputType.streetAddress,
                      // focusNode: Constants.focusNodeEmailLogin,
                    ),
                    SizedBox(
                      height: 220.h,
                    ),
                    CustomContainerButton(
                      text: StringResource.SaveBtnText,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = FirebaseFirestore.instance
                              .collection('addClient')
                              .doc(Helper.data['id']);
                          user.update({
                            'ClientAddress':
                                clientAddressController.text.toString(),
                            'clientName': clientNameController.text.toString(),
                            "phoneNo": clientPhoneNoController.text.toString(),
                          });

                          Helper.showToast('Updated.....');
                          log("Trash Clicked");
                        }
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomContainerButton(
                      text: StringResource.DiscardBtnText,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => InvoicesScreen("Clients"),
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
    );
  }
}
