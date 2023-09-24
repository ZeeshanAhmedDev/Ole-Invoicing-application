import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/custom_widgets/textFeild.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectCategories/newModelForCategory.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectCategories/selectCategoriesModel.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/constant.dart';
import '../../../utils/helper.dart';
import '../InvoiceScreens/create_invoice_screen.dart';

bool enableField = false;
// List<bool> enableField = [];

List<dynamic> checkBoxSelectedItems = [];

class SelectCategoriesScreen extends StatefulWidget {
  const SelectCategoriesScreen({Key? key}) : super(key: key);

  @override
  _SelectCategoriesScreenState createState() => _SelectCategoriesScreenState();
}

class _SelectCategoriesScreenState extends State<SelectCategoriesScreen> {
  /// ====================================================================

  List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
      [];

  // ----------------------------------------------------------------------
  List<TextEditingController> nameControllers = [];
  List<SizedBox> nameFields = [];

  //----------------------------------------------------------------
  List<TextEditingController> descriptionControllers = [];
  List<SizedBox> descriptionFields = [];

  void _onPress() {
    /// ==========================================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    /// ==========================================================================
    final name = MaskedTextController(mask: '0000');
    final description = MaskedTextController(mask: '0000');
    // final name = TextEditingController();
    // final description = TextEditingController();

    ///=====================================================================
    final nameField = _generateNameTextField(name, "Supplies");
    final descriptionField =
        _generateDesTextField(description, "Amount Billed");

    ///=====================================================================

    setState(() {
      nameControllers.add(name);
      descriptionControllers.add(description);

      ///=====================================================================

      nameFields.add(nameField);
      descriptionFields.add(descriptionField);
    });
  }

  Widget _addTile() {
    return Padding(
      padding: EdgeInsets.only(left: 220.w),
      child: ListTile(
        title: Text(
          LocaleKeys.addMoreWorkersTxt.tr(),
          style: const TextStyle(
            color: Color(0xff4C78BC),
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: _onPress,
      ),
    );
  }

  SizedBox _generateNameTextField(
      TextEditingController controller, String hint) {
    return SizedBox(
      width: 100.w,
      child: TextFormField(
        //   validator: (value) {
        //     if (value!.trimLeft().isEmpty) {
        //       return "Enter supplies";
        //     }
        //     return null;
        //   },
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Color(Constants.lightgreen),
        style: TextStyle(fontSize: 17.sp, color: Color(Constants.lightgreen)),
        decoration: InputDecoration(
            counterText: '',
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(55.r)),
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(55.r)),
              // borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.red,
              ),
            ),
            hintText: hint,
            hintStyle: TextStyle(
                color: Color(Constants.lightgreen),
                textBaseline: TextBaseline.alphabetic,
                fontSize: 14.sp),
            fillColor: Color(Constants.feildColor),
            filled: true,

            // isDense: true,
            contentPadding: EdgeInsets.only(
              top: 18.h,
              bottom: 18.h,
              left: 27.w,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(Constants.lightgreen)),
              borderRadius: BorderRadius.circular(55.sp),
              // borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(Constants.lightgreen)),
              borderRadius: BorderRadius.circular(45.sp),
              // borderRadius: BorderRadius.zero,
            )),
      ),
    );
  }

  SizedBox _generateDesTextField(
      TextEditingController controller, String hint) {
    return SizedBox(
      width: 100.w,
      child: TextFormField(
        //   validator: (value) {
        //     if (value!.trimLeft().isEmpty) {
        //       return "Enter supplies";
        //     }
        //     return null;
        //   },
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Color(Constants.lightgreen),
        style: TextStyle(fontSize: 17.sp, color: Color(Constants.lightgreen)),
        decoration: InputDecoration(
            counterText: '',
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(55.r)),
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(55.r)),
              // borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.red,
              ),
            ),
            hintText: hint,
            hintStyle: TextStyle(
                color: Color(Constants.lightgreen),
                textBaseline: TextBaseline.alphabetic,
                fontSize: 14.sp),
            fillColor: Color(Constants.feildColor),
            filled: true,

            // isDense: true,
            contentPadding: EdgeInsets.only(
              top: 18.h,
              bottom: 18.h,
              left: 27.w,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(Constants.lightgreen)),
              borderRadius: BorderRadius.circular(55.sp),
              // borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(Constants.lightgreen)),
              borderRadius: BorderRadius.circular(45.sp),
              // borderRadius: BorderRadius.zero,
            )),
      ),
    );
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < nameControllers.length; i++)
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                nameFields.first,
                descriptionFields.first,
              ],
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 250.w,
        child: Row(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in nameControllers) {
      controller.dispose();
    }
    for (final controller in descriptionControllers) {
      controller.dispose();
    }
    // _okController.dispose();
    super.dispose();
  }

  // Future<void> showTextFieldOnCondition(int index) async {
  //   // ignore: iterable_contains_unrelated_type
  //   if (categoriesNames.contains(index) == _nameControllers.contains(index)) {
  //     if (kDebugMode) {
  //       print("same matching");
  //       // enableField = true;
  //       setState(() {});
  //     }
  //   }
  // }

  // final _okController = TextEditingController();
  // Widget _okButton(BuildContext context) {
  //   final textField = TextField(
  //     controller: _okController,
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //     ),
  //   );
  //
  //   // final button = ElevatedButton(
  //   //   onPressed: () async {
  //   //     final index = int.parse(_okController.text);
  //   //     String text = "name: ${_nameControllers[index].text}\n" +
  //   //         "tel: ${_telControllers[index].text}\n" +
  //   //         "address: ${_addressControllers[index].text}";
  //   //     await Fluttertoast.showToast(
  //   //       msg: "Result",
  //   //     );
  //   //   },
  //   //   child: Text("OK"),
  //   // );
  //
  //   return Row(
  //     mainAxisSize: MainAxisSize.max,
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       Container(
  //         child: textField,
  //         width: 100,
  //         height: 50,
  //       ),
  //       button,
  //     ],
  //   );
  // }

  // ----------------------------------------------------------------------

  /// ====================================================================
  ///

  final controller = TextEditingController();
  static const myStyle = TextStyle(
    fontWeight: FontWeight.w800,
  );

  /// ====================================================================

  final List<dynamic> categoriesNames = [];
  final List<dynamic> boolChecking = [];
  final List _selectedCategoriesId = [];

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _onPress();
    });
    // add client
    FirebaseFirestore.instance
        .collection('addWorkDescription')
        .get()
        .then((QuerySnapshot? querySnapshot) {
      for (var doc in querySnapshot!.docs) {
        if (kDebugMode) {
          setState(() {
            boolChecking.add(false);
            categoriesNames.add(doc["workDescription"]);
            // _selectedCategoriesId.add(doc["id"]);
            if (kDebugMode) {
              print(doc["workDescription"]);
            }
          });
        }
      }
    });
    super.initState();
  }

  final List _selectedCategories = [
    // CheckBoxSettingsForCategoriesModel(title: "title", price: 12),
    // CheckBoxSettingsForCategoriesModel(title: "title", price: 12),
    // CheckBoxSettingsForCategoriesModel(title: "title", price: 12),
    // CheckBoxSettingsForCategoriesModel(title: "title", price: 12),
  ];

  final _formKey = GlobalKey<FormState>();
  bool isEmpty = false;

  // Map<String, bool> values = {
  //   'foo': true,
  //   'bar': false,
  // };

// final checkTextList = [
//   CheckBoxSettingsForCategoriesModel(title: 'Demolition', price: 150),
//   CheckBoxSettingsForCategoriesModel(title: 'Framing', price: 150),
//   CheckBoxSettingsForCategoriesModel(title: 'Plumb and line', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Shear panel Installation', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Floor joist Installation', price: 150),
//   CheckBoxSettingsForCategoriesModel(title: 'Floor sheeting', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Hardware Installation', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Ceiling Joist Installation ', price: 150),
//   CheckBoxSettingsForCategoriesModel(title: 'Rook Stack', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Installation of Roof Sheeting', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Install Doors, Windows', price: 150),
//   CheckBoxSettingsForCategoriesModel(
//       title: 'Install Interior, Doors', price: 150),
// ];
  @override
  Widget build(BuildContext context) {
    //====================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //====================================================
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () => Helper.onWillPopFunc(
            context: context,
            className:
                CreateInvoiceScreenNew(checkBoxSettingsForCategoriesModel)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            fun: () => Navigator.pop(context),
            elevation: 0,
            title: LocaleKeys.selectCategories_txt.tr(),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: Colors.white10,
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0.h),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 28.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.description_txt.tr(),
                              style: myStyle,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 100.w),
                                  child: const Text(
                                    'Supplies',
                                    style: myStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.07),
                                  child: const Text('Amount Billed',
                                      style: myStyle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height: height, child: _listView()),
                      // _addTile(),
                      Row(
                        children: [
                          ///description
                          NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (overScroll) {
                              overScroll.disallowIndicator();
                              return true;
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  /*        Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.description_txt.tr(),
                                        style: myStyle,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Supplies',
                                            style: myStyle,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.1),
                                            child: const Text('Amount Billed',
                                                style: myStyle),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),*/
                                  Helper.customSizedBox,
                                  Helper.customSizedBox,
                                  Container(
                                    child: SizedBox(
                                      height: height,
                                      width: width,
                                      child: NotificationListener<
                                          OverscrollIndicatorNotification>(
                                        onNotification: (overScroll) {
                                          overScroll.disallowIndicator();
                                          return true;
                                        },
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              height: height * 0.01,
                                            );
                                          },
                                          itemBuilder: (_, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(width: 10),
                                                // Checkbox(
                                                //   value: categoriesNames
                                                //           .contains(index)
                                                //       ? true
                                                //       : false,
                                                //   onChanged: (bool? value) {
                                                //     // categoriesNames[index]
                                                //     //     .isNotEmpty = value;
                                                //   },
                                                //   activeColor:
                                                //       const Color(0xff61ACBE),
                                                // ),
                                                Expanded(
                                                  child: ListTile(
                                                    leading: SizedBox(
                                                      width: 14.w,
                                                      child: Checkbox(
                                                        value:
                                                            boolChecking[index],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            boolChecking[
                                                                index] = value!;
                                                            log(boolChecking[
                                                                    index]
                                                                .toString());
                                                          });

                                                          /*  setState(() {
                                                            _onPress();
                                                          });*/
                                                        },
                                                        activeColor:
                                                            const Color(
                                                                0xff61ACBE),
                                                      ),
                                                    ),

                                                    title: Text(
                                                      categoriesNames[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17.h),
                                                    ),
                                                    // trailing: nameFields[index],
                                                    trailing: textField(
                                                      "\$",
                                                      100.w,
                                                      controller: controller,
                                                      maximumLength: 10,
                                                      // keyboardType: TextInputType.name,
                                                      isBorderRadius: true,
                                                      validatorr: (value) {
                                                        if (value!
                                                            .trimLeft()
                                                            .isEmpty) {
                                                          return "Enter rate";
                                                        }
                                                        return null;
                                                      },
                                                      // focusNode: Constants.focusNodeEmailLogin,
                                                    ),

                                                    // title: Checkbox(
                                                    //   value: categoriesNames
                                                    //           .contains(index)
                                                    //       ? true
                                                    //       : false,
                                                    //   onChanged: (bool? value) {
                                                    //     // categoriesNames[index]
                                                    //     //     .isNotEmpty = value;
                                                    //   },
                                                    //   activeColor: const Color(
                                                    //       0xff61ACBE),
                                                    // ),
                                                    // CheckboxListTile(
                                                    //   onChanged: (bool? value) {},
                                                    //   value: enableField,
                                                    //   title: Text(
                                                    //       categoriesNames[index]),
                                                    //   controlAffinity:
                                                    //   ListTileControlAffinity
                                                    //       .leading,
                                                    //   // secondary:
                                                    //   //     Icon(Icons.eighteen_mp),
                                                    // )
                                                  ),
                                                ),

                                                // Text(
                                                //   categoriesNames[index]
                                                //       .toString(),
                                                //   style:
                                                //       TextStyle(fontSize: 17.h),
                                                // ),
                                                // SizedBox(
                                                //   width: 10.w,
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceEvenly,
                                                //   children: [
                                                //     //Supplies Amount
                                                //     // textField(
                                                //     //   "\$",
                                                //     //   100.w,
                                                //     //   controller: controller,
                                                //     //   maximumLength: 10,
                                                //     //   // keyboardType: TextInputType.name,
                                                //     //   isBorderRadius: true,
                                                //     //   validatorr: (value) {
                                                //     //     if (value!
                                                //     //         .trimLeft()
                                                //     //         .isEmpty) {
                                                //     //       return "Enter rate";
                                                //     //     }
                                                //     //     return null;
                                                //     //   },
                                                //     //   // focusNode: Constants.focusNodeEmailLogin,
                                                //     // ),
                                                //
                                                //     //Amount Billed
                                                //     // textField(
                                                //     //   "\$",
                                                //     //   100.w,
                                                //     //   controller: controller,
                                                //     //   maximumLength: 10,
                                                //     //   // keyboardType: TextInputType.name,
                                                //     //   isBorderRadius: true,
                                                //     //   validatorr: (value) {
                                                //     //     if (value!
                                                //     //         .trimLeft()
                                                //     //         .isEmpty) {
                                                //     //       return "Enter rate";
                                                //     //     }
                                                //     //     return null;
                                                //     //   },
                                                //     //   // focusNode: Constants.focusNodeEmailLogin,
                                                //     // ),
                                                //   ],
                                                // ),

                                                /*     textField(
                                                  "\$",
                                                  100.w,
                                                  controller: controller,
                                                  maximumLength: 10,
                                                  // keyboardType: TextInputType.name,
                                                  isBorderRadius: true,
                                                  validatorr: (value) {
                                                    if (value!
                                                        .trimLeft()
                                                        .isEmpty) {
                                                      return "Enter rate";
                                                    }
                                                    return null;
                                                  },
                                                  // focusNode: Constants.focusNodeEmailLogin,
                                                ),*/
                                                SizedBox(
                                                  width: 100.w,
                                                  child:
                                                      descriptionFields.first,
                                                ),

                                                // Expanded(child: _listView()),
                                              ],
                                            );
                                          },
                                          itemCount: categoriesNames.length,
                                        ),
                                      ),

                                      // ListView.builder(
                                      //   itemCount: categoriesNames.length,
                                      //   itemBuilder: (context, index) {
                                      //     return CheckboxListTile(
                                      //       title: Text(categoriesNames[index]),
                                      //       value: categoriesNames.contains(index),
                                      //       onChanged: (newValue) {
                                      //         setState(() {
                                      //           if (categoriesNames.contains(index)) {
                                      //             categoriesNames
                                      //                 .remove(index); // unselect
                                      //           } else {
                                      //             categoriesNames.add(index); // select
                                      //           }
                                      //           setState(() {});
                                      //           isChecked = newValue!;
                                      //         });
                                      //       },
                                      //       controlAffinity:
                                      //           ListTileControlAffinity.leading,
                                      //     );
                                      //   },
                                      // ),
                                    ),
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                  ),
                                  SizedBox(
                                    height: 400.h,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /*  ///supplies
                          // Column(
                          //   children: [
                          //     NotificationListener<
                          //         OverscrollIndicatorNotification>(
                          //       onNotification: (overScroll) {
                          //         overScroll.disallowIndicator();
                          //         return true;
                          //       },
                          //       child: SingleChildScrollView(
                          //         scrollDirection: Axis.horizontal,
                          //         physics: const AlwaysScrollableScrollPhysics(),
                          //         child: Column(
                          //           children: [
                          //             Helper.customSizedBox,
                          //             Helper.customSizedBox,
                          //             Container(
                          //               child: SizedBox(
                          //                 height: height,
                          //                 width: 120.w,
                          //                 child: NotificationListener<
                          //                     OverscrollIndicatorNotification>(
                          //                   onNotification: (overScroll) {
                          //                     overScroll.disallowIndicator();
                          //                     return true;
                          //                   },
                          //                   child: ListView.separated(
                          //                     separatorBuilder:
                          //                         (BuildContext context,
                          //                             int index) {
                          //                       return SizedBox(
                          //                         height: height * 0.01,
                          //                       );
                          //                     },
                          //                     // itemExtent: 40.h,
                          //                     physics:
                          //                         const BouncingScrollPhysics(),
                          //                     itemBuilder: (_, index) {
                          //                       return Padding(
                          //                         padding: EdgeInsets.only(
                          //                             left: 13.0.w),
                          //                         child: textField(
                          //                           "\$",
                          //                           10.w,
                          //                           controller: controller,
                          //                           maximumLength: 10,
                          //                           // keyboardType: TextInputType.name,
                          //                           isBorderRadius: true,
                          //                           validatorr: (value) {
                          //                             if (value!
                          //                                 .trimLeft()
                          //                                 .isEmpty) {
                          //                               return "Enter rate";
                          //                             }
                          //                             return null;
                          //                           },
                          //                           // focusNode: Constants.focusNodeEmailLogin,
                          //                         ),
                          //                       );
                          //                     },
                          //                     itemCount: categoriesNames.length,
                          //                   ),
                          //                 ),
                          //               ),
                          //               color: Colors.transparent,
                          //               alignment: Alignment.center,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Column(
                          //   children: [
                          //     _addTile(),
                          //     Expanded(child: _listView()),
                          //     _okButton(),
                          //   ],
                          // ),

                          Column(
                            children: [
                              NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overScroll) {
                                  overScroll.disallowIndicator();
                                  return true;
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Helper.customSizedBox,
                                      Helper.customSizedBox,
                                      Container(
                                        child: SizedBox(
                                          height: height,
                                          width: 120.w,
                                          child: NotificationListener<
                                              OverscrollIndicatorNotification>(
                                            onNotification: (overScroll) {
                                              overScroll.disallowIndicator();
                                              return true;
                                            },
                                            child: _listView(),
                                          ),
                                        ),
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///Amount
                          Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (overScroll) {
                                overScroll.disallowIndicator();
                                return true;
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Helper.customSizedBox,
                                    Helper.customSizedBox,
                                    Container(
                                      child: SizedBox(
                                        height: height,
                                        width: 120.w,
                                        child: NotificationListener<
                                            OverscrollIndicatorNotification>(
                                          onNotification: (overScroll) {
                                            overScroll.disallowIndicator();
                                            return true;
                                          },
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return SizedBox(
                                                height: height * 0.01,
                                              );
                                            },
                                            // itemExtent: 40.h,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (_, index) {
                                              return Padding(
                                                padding:
                                                    EdgeInsets.only(left: 13.0.w),
                                                child: textField(
                                                  "\$",
                                                  10.w,
                                                  controller: controller,
                                                  maximumLength: 10,
                                                  // keyboardType: TextInputType.name,
                                                  isBorderRadius: true,
                                                  validatorr: (value) {
                                                    if (value!
                                                        .trimLeft()
                                                        .isEmpty) {
                                                      return "Enter rate";
                                                    }
                                                    return null;
                                                  },
                                                  // focusNode: Constants.focusNodeEmailLogin,
                                                ),
                                              );
                                            },
                                            itemCount: categoriesNames.length,
                                          ),
                                        ),
                                      ),
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: const [
          //         Text(
          //           'Supplies',
          //           style: myStyle,
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: const [
          //         Text(
          //           'Amount Billed',
          //           style: myStyle,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // child: ListView(
          //   children: [
          //     ...checkTextList.map(buildSingleCheckBox).toList(),
          //   ],
          // ),
          // ),
          bottomNavigationBar: SizedBox(
            height: 80.h,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomContainerButton(
                        text: LocaleKeys.save_txt.tr(),
                        onPressed: () {
                          // ===========================================================================
                          // final name = TextEditingController();
                          // final tel = TextEditingController();
                          // final address = TextEditingController();
                          //
                          // final nameField = _generateTextField(name, "name");
                          // final telField = _generateTextField(tel, "mobile");
                          // final addressField =
                          //     _generateTextField(address, "address");
                          //
                          // setState(() {
                          //   _nameControllers.add(name);
                          //   _telControllers.add(tel);
                          //   _addressControllers.add(address);
                          //   _nameFields.add(nameField);
                          //   _telFields.add(telField);
                          //   _addressFields.add(addressField);
                          // });
                          // ===========================================================================

                          //here
                          for (int i = 0; i < boolChecking.length; i++) {
                            if (boolChecking[i]) {
                              //
                              Helper.strList.add(categoriesNames[i] +
                                  "   " +
                                  // nameControllers[i].text +
                                  controller.text +
                                  "   " +
                                  descriptionControllers[0].text);
                              log(Helper.strList[0]);

                              // CategoriesModel();

                              Helper.strListOfCategories.add(
                                CategoriesModel(
                                    categoriesNames[i],
                                    controller.text,
                                    descriptionControllers[0].text),
                              );

                              /*       Helper.str = categoriesNames[i] +
                                  "   " +
                                  // nameControllers[i].text +
                                  controller.text +
                                  "   " +
                                  descriptionControllers[0].text;
                              log(Helper.str);*/

                              /*  checkBoxSettingsForCategoriesModel
                                  .add(CheckBoxSettingsForCategoriesModel(
                                controller.text,
                                descriptionControllers[0].text,
                                categoriesNames[i].text.toString(),
                              ));*/
                            }
                          }

                          Navigator.pop(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateInvoiceScreenNew(
                                  checkBoxSettingsForCategoriesModel),
                            ),
                          );

                          /*  if (isEmpty == false) {
                            //

                            // Helper.showToast('Please select categories');
                            Helper.showToast(
                                LocaleKeys.pleaseSelectCategoriesMsg_text.tr());
                          } else {
                            Navigator.pop(context);
                            if (kDebugMode) {
                              print("selected==============>" +
                                  categoriesNames.toString());
                            }
                            // Navigator.pushReplacement(
                            //     context,
                            //     CupertinoPageRoute(
                            //       builder: (context) =>
                            //           CreateInvoiceScreenNew(),
                            //     ));
                          }*/
                        },
                      ),
                      /* SizedBox(
                        height: 40.h,
                      ),
                      CustomContainerButton(
                        text: StringResource.backBtnTxt,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateInvoiceScreenNew(),
                            ),
                          );
                        },
                        isActive: false,
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "5", "category_name": "Barber"},
      {"category_id": "3", "category_name": "Carpanter"},
      {"category_id": "7", "category_name": "Cook"}
    ],
    "responseTotalResult":
        3 // Total result is 3 here becasue we have 3 categories in responseBody.
  };

  void _onCategorySelected(bool selected, categoryId) {
    if (selected == true) {
      setState(() {
        _selectedCategories.add(categoryId);
      });
    } else {
      setState(() {
        _selectedCategories.remove(categoryId);
      });
    }
  }

//   Widget buildSingleCheckBox(
//           CheckBoxSettingsForCategoriesModel settingsModel) =>
//       buildCheckBox(
//           settingsModel: settingsModel,
//           onClicked: () {
//             setState(() {
//               final newValue = !settingsModel.value;
//               final newtitle = settingsModel.title;
//               final newPrice = settingsModel.price;
//               settingsModel.value = newValue;
//
//               if (kDebugMode) {
//                 print(newValue);
//                 print(newtitle);
//                 print(newPrice);
//               }
//               if (newValue == false) {
//                 isEmpty = false;
//                 setState(() {});
//               } else {
//                 isEmpty = true;
//               }
//             });
//           });
//
//   Widget buildCheckBox({
//     required CheckBoxSettingsForCategoriesModel settingsModel,
//     required Function() onClicked,
//   }) =>
//       ListTile(
//         onTap: onClicked,
//         // onTap: () {
//         //   // setState(() {
//         //   //   this.value = !value;
//         //   //   if (kDebugMode) {
//         //   //     print(this.value);
//         //   //   }
//         //   // });
//         // },
//         leading: Checkbox(
//           activeColor: Color(0xff61ACBE),
//           value: settingsModel.value,
//           onChanged: (bool? value) => onClicked(),
//           // {
//           // setState(() {
//           //   this.value = value!;
//           //   if (kDebugMode) {
//           //     print(this.value);
//           //   }
//           // });
//           // },
//         ),
//         title: Text(settingsModel.title),
//         trailing: Text(settingsModel.price.toString()),
//       );

}
