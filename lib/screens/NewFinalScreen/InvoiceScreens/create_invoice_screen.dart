import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ole_app/screens/NewFinalScreen/InvoiceScreens/pdfGenerationForInvoiceCreation/PdfInvoiceApi.dart';
import 'package:ole_app/screens/NewFinalScreen/InvoiceScreens/pdfGenerationForInvoiceCreation/fileHandler.dart';
import 'package:ole_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../Provider.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../models/previous_invoice_Model.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/constant.dart';
import '../../../utils/controllers.dart';
import '../../../utils/helper.dart';
import '../../menu_screen.dart';
import '../SelectCategories/selectCategoriesModel.dart';
import '../SelectCategories/select_categories_view.dart';
import '../TimeSheetScreen/pdfGenerationForTimeSheet/data model.dart';
import 'invoice_preview_screen.dart';
import 'newInvoiceDataModel.dart';
import 'package:collection/collection.dart';

class CreateInvoiceScreenNew extends StatefulWidget {
  // var weekEndingDate;
  // var customerNames;
  // List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel;
  CreateInvoiceScreenNew(
      List<CheckBoxSettingsForCategoriesModel>
          checkBoxSettingsForCategoriesModel
      // this.weekEndingDate,
      // this.customerNames,
      //{
      // required this.checkBoxSettingsForCategoriesModel,
      //}
      );

  // List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel;
  // var categoryDescription;
  // var suppliesAmount;
  // var billedAmount;
  //
  // List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
  //     [];

  @override
  _CreateInvoiceScreenNewState createState() => _CreateInvoiceScreenNewState();
}

class _CreateInvoiceScreenNewState extends State<CreateInvoiceScreenNew> {
  List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
      [];
  final myTotalStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );
  var distinctIdsfordropdownNames = [
    ...{...Helper.dropdownNames}
  ];

  var distinctIdsfordropdownNamesForWorkers = [
    ...{...Helper.dropdownNamesForWorkers}
  ];

  bool isClicked = false;

  /// ======================================================================================================== ///
  final CollectionReference clients =
      FirebaseFirestore.instance.collection('addClient');

  List<String> clientNames = [];
  List<String> workerNames = [];
  final list = [1, 2, 3, 4];

  List<DataModelForInvoice> dataModelForInvoice = [];

  /// ======================================================================================================== ///
  @override
  void dispose() {
    _cardListForWorkers.clear();
    _cardList.clear();
    super.dispose();
  }

  var format, date;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      // _addCardWidgetForWorkers(MediaQuery.of(context).size.height, date, format,
      //     MediaQuery.of(context).size.height);
    });
    super.initState();

    // add client
    FirebaseFirestore.instance
        .collection('addClient')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (kDebugMode) {
          setState(() {
            clientNames.add(doc["clientName"]);
            if (kDebugMode) {
              print(doc["clientName"]);
            }
          });
        }
      }
    });

    // add workers

    FirebaseFirestore.instance
        .collection('editWorker')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (kDebugMode) {
          setState(() {
            workerNames.add(doc["workerClientName"]);
            if (kDebugMode) {
              print(doc["workerClientName"]);
            }
          });
        }
      }
    });
  }

  // --------------------------------------------------------------------------------------------- // Render Dropdown Dynamically
  final List<Widget> _cardList = [];

  void _addCardWidget() {
    setState(() {
      _cardList.add(_card());
    });
  }

  String? dropdownValue;
  String? dropdownValue2;

  // --------------------------------------------------------------------------------------------- // Render Dropdown Dynamically

  Widget _card() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff6fc4db), // red as border color
          ),
          color: const Color(0xff6fc4db).withOpacity(0.2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        width: 400.w,

        // padding: const EdgeInsets.all(0.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0.w),
              // helperText: 'ss',
              // errorStyle: TextStyle(fontSize: 4),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              // isDense: true,
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return LocaleKeys.pleaseSelectClientValidationMsg.tr();
              }
              return null;
            },
            icon: Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xff6fc4db),
              ),
            ),
            isExpanded: true,
            value: dropdownValue,
            style: const TextStyle(
                // fontWeight: FontWeight.w500,
                color: Color(0xff6fc4db)),
            items: clientNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: clientNames.isNotEmpty ? value : null,
                child: Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: Text(
                    value,
                    style: TextStyle(
                        color: const Color(0xff6fc4db), fontSize: 17.sp),
                  ),
                ),
              );
            }).toList(),
            hint: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                LocaleKeys.selectCustomers_txt.tr(),
                style:
                    TextStyle(color: const Color(0xff6fc4db), fontSize: 17.sp),
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                Helper.dropdownNames.add(value!);
              });
            },
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------------- //

  // this is for Adding worker dynamically ==============================================
  final List<Widget> _cardListForWorkers = [];

  void _addCardWidgetForWorkers(width, date, format, height) {
    setState(() {
      _cardListForWorkers.add(_cardForWorkers(width, date, format, height));
    });
  }

  Widget _cardForWorkers(width, date, format, height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(left: width * 0.08),
        //       child: Text(
        //         LocaleKeys.selectWorkers_txt.tr(),
        //         style: myStyle,
        //       ),
        //     ),
        //     // Padding(
        //     //   padding: EdgeInsets.only(left: width * 0.31),
        //     //   child: TextButton(
        //     //     onPressed: () {
        //     //       _addCardWidgetForWorkers(width, date, format, height);
        //     //
        //     //       /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------
        //     //
        //     //       //In each button onPressed/onTap
        //     //       controller.animateTo(4000,
        //     //           duration: const Duration(seconds: 1), curve: Curves.ease);
        //     //
        //     //       /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------
        //     //     },
        //     //     child: Text(
        //     //       LocaleKeys.AddWorker.tr(),
        //     //       style: const TextStyle(color: Colors.blue),
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        // ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.035),
                child: Text(
                  LocaleKeys.selectWorkers_txt.tr(),
                  style: myStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.152),
                child: _cardListForWorkers.isEmpty
                    ? TextButton(
                        onPressed: () {
                          _addCardWidgetForWorkers(width, date, format, height);

                          /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------

                          //In each button onPressed/onTap
                          controller.animateTo(3000,
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease);

                          /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------
                        },
                        child: Text(
                          LocaleKeys.AddWorker.tr(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        Helper.customSizedBox,
        Padding(
          padding: EdgeInsets.only(left: width * 0.01),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff6fc4db), // red as border color
              ),
              color: const Color(0xff6fc4db).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r),
            ),
            width: 400.w,

            // padding: const EdgeInsets.all(0.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0.w),
                  // helperText: 'ss',
                  // errorStyle: TextStyle(fontSize: 4),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  // isDense: true,
                ),
                // validator: (value) {
                //   if (value?.isEmpty ?? true) {
                //     return LocaleKeys.pleaseSelectClientValidationMsg.tr();
                //   }
                //   return null;
                // },
                icon: Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xff6fc4db),
                  ),
                ),
                isExpanded: true,
                value: dropdownValue2,
                style: const TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: Color(0xff6fc4db)),
                items:
                    workerNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: workerNames.isNotEmpty ? value : null,
                    child: Padding(
                      padding: EdgeInsets.only(left: 27.w),
                      child: Text(
                        value,
                        style: TextStyle(
                            color: const Color(0xff6fc4db), fontSize: 17.sp),
                      ),
                    ),
                  );
                }).toList(),
                hint: Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    LocaleKeys.selectWorkers_txt.tr(),
                    style: TextStyle(
                        color: const Color(0xff6fc4db), fontSize: 17.sp),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    Helper.dropdownNamesForWorkers.add(value!);
                  });
                },
              ),
            ),
          ),
        ),
        Helper.customSizedBox,
        Helper.customSizedBox,
        Padding(
          padding: EdgeInsets.only(left: width * 0.035),
          child: Text(
            '${LocaleKeys.week_ending_date.tr()}: ',
            style: myStyle,
          ),
        ),
        Helper.customSizedBox,
        Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: SizedBox(
            width: width * 0.445,
            // height: height * 0.07,
            child: Theme(
              data: ThemeData.light().copyWith(
                  primaryColor: Color(Constants.lightgreen),
                  buttonTheme: const ButtonThemeData(
                    textTheme: ButtonTextTheme.primary,
                  ),
                  colorScheme:
                      ColorScheme.light(primary: Color(Constants.lightgreen))
                          .copyWith(secondary: Color(Constants.lightgreen))),
              child: DateTimeField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (values) {
                  if (values == null) {
                    return LocaleKeys.pleaseEnterDateMsg_text.tr();
                  }
                  return null;
                },
                resetIcon: null,
                onChanged: (value) {
                  setState(() {
                    date.weekEndingDateMethod(value);
                    if (kDebugMode) {
                      print(date.weekEndingDate);
                    }
                  });
                },
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                },
                cursorColor: Color(Constants.lightgreen),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(Constants.lightgreen),
                ),
                decoration: InputDecoration(
                  // counterText: ' ',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(height * 0.1),
                    borderSide: BorderSide(
                      width: 1.w,
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(height * 0.1),
                  ),
                  // hintText: widget.weekEndingDate ?? LocaleKeys.date_txt.tr(),
                  hintText: LocaleKeys.date_txt.tr(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.06),
                  hintStyle: TextStyle(
                      color: Color(Constants.lightgreen),
                      textBaseline: TextBaseline.alphabetic,
                      fontSize: 17.sp),
                  fillColor: Color(Constants.feildColor),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    borderRadius: BorderRadius.circular(height * 0.1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    borderRadius: BorderRadius.circular(height * 0.1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.035),
          child: TextButton(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SelectCategoriesScreen(),
                )),
            child: Text(
              LocaleKeys.selectCategories_txt.tr(),
              style: const TextStyle(
                color: Color(0xff4C78BC),
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Helper.customSizedBox,
        Helper.customSizedBox,
        Helper.customSizedBox,
      ],
    );
  }

  // this is for Adding worker dynamically ==============================================

  final _multiSelectKey = GlobalKey<FormFieldState>();
  final _multiSelectKey2 = GlobalKey<FormFieldState>();

  static final List<String> _animals = [
    'test', 'Ahmed', 'ali', // PreviousInvoicesModel(
  ];
  static final List<String> _animals2 = [
    'Ahsan', 'Zeeshan Ahmed', // PreviousInvoicesModel(
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<String>(animal, animal.toString()))
      .toList();
  final _items2 = _animals2
      .map((animal) => MultiSelectItem<String>(animal, animal.toString()))
      .toList();

  List<String?> _selectedAnimals3 = [];
  List<String?> _selectedAnimals4 = [];
  // --------------------------------------------------------------------------------- //
  final _selectcustomerContorller = TextEditingController();

  // void _showMultiSelect() async {
  //   final List<String> _items = [
  //     'Flutter',
  //     'Node.js',
  //     'React Native',
  //     'Java',
  //     'Docker',
  //     'MySQL'
  //   ];
  //
  //   final List<String>? results = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  //           stream: FirebaseFirestore.instance
  //               .collection('addClient')
  //               .orderBy('createdAt')
  //               .snapshots(),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasError) {
  //               return Text('Error = ${snapshot.error}');
  //             }
  //             if (snapshot.hasData) {
  //               final docs = snapshot.data!.docs;
  //               final data = docs[1].data();
  //               return MultiSelect(items: _items);
  //             }
  //             return MultiSelect(items: _items);
  //           });
  //     },
  //   );
  //
  //   // Update UI
  //   if (results != null) {
  //     setState(() {
  //       Helper.selectedItems = results;
  //     });
  //   } else {
  //     log("please select value");
  //   }
  // }

  final myStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    //========================================================
    Helper.time =
        DateTime.now().millisecondsSinceEpoch.remainder(100000).toString();
    ControllersTextFields.instance.invoiceNoController.text = Helper.time;
    //========================================================
    super.didChangeDependencies();
  }

  ScrollController controller = ScrollController();
  // DateTime? currentBackPressTime;
  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
  //     currentBackPressTime = now;
  //     isClicked = false;
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CreateInvoiceScreenNew(checkBoxSettingsForCategoriesModel
                    // checkBoxSettingsForCategoriesModel:
                    //     checkBoxSettingsForCategoriesModel,
                    ),
          ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    //====================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    format = DateFormat("dd-MM-yy");
    date = Provider.of<DataProviders>(context);
    //====================================================
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: isClicked == false
                ? CustomAppBar(
                    fun: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const MenuScreen(),
                        )),
                    elevation: 0,
                    title: LocaleKeys.create_invoice_txt.tr(),
                  )
                : CustomAppBar(
                    // title: 'Invoice Preview',
                    title: LocaleKeys.invoice_preview_txt.tr(),
                    fun: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CreateInvoiceScreenNew(
                              checkBoxSettingsForCategoriesModel
                              // checkBoxSettingsForCategoriesModel
                              ),
                        )),
                    elevation: 0),
            body: isClicked == false
                ? Container(
                    color: Colors.white10,
                    height: 1.sh,
                    width: 1.sw,
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.08),
                                child: Text(
                                  LocaleKeys.selectCustomers_txt.tr(),
                                  style: myStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.23),
                                child: TextButton(
                                  onPressed: _addCardWidget,
                                  child: Text(
                                    LocaleKeys.add_customer_text.tr(),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Helper.customSizedBox,
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                          //   child: DropdownButtonHideUnderline(
                          //     child: Container(
                          //       height: 60.h,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(13.r),
                          //         color: const Color(0xff6fc4db).withOpacity(0.3),
                          //       ),
                          //       child: DropdownButtonFormField<String>(
                          //         // validator: (value) {
                          //         //   if (value == null || value == '') {
                          //         //     return LocaleKeys.pleaseSelectClientValidationMsg
                          //         //         .tr();
                          //         //   }
                          //         //   return null;
                          //         // },
                          //         decoration: const InputDecoration(
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.transparent),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.transparent),
                          //           ),
                          //           isDense: true,
                          //         ),
                          //         isExpanded: true,
                          //         value: dropdownValue,
                          //         isDense: true,
                          //         icon: Padding(
                          //           padding: EdgeInsets.only(
                          //             right: 4.w,
                          //             top: 8.h,
                          //           ),
                          //           child: const Icon(
                          //             Icons.keyboard_arrow_down_outlined,
                          //             color: Colors.black54,
                          //           ),
                          //         ),
                          //         hint: Padding(
                          //           padding: EdgeInsets.only(
                          //             left: 23.w,
                          //             top: 8.h,
                          //           ),
                          //           child: Text(
                          //             LocaleKeys.selectCustomers_txt.tr(),
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //               fontSize: 18.h,
                          //             ),
                          //           ),
                          //         ),
                          //         onChanged: (salutation) => setState(
                          //             () => Helper.dropdownNames.add(salutation!)),
                          //         items: clientNames
                          //             .map<DropdownMenuItem<String>>((String value) {
                          //           return DropdownMenuItem<String>(
                          //             value: value,
                          //             child: Padding(
                          //               padding: EdgeInsets.only(
                          //                 left: 16.w,
                          //                 top: 8.h,
                          //               ),
                          //               child: Text(
                          //                 value,
                          //                 style: TextStyle(
                          //                   color: Colors.black54,
                          //                   fontSize: 16.h,
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         }).toList(),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          /// Dropdown
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                      0xff6fc4db), // red as border color
                                ),
                                color: const Color(0xff6fc4db).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              width: 400.w,

                              // padding: const EdgeInsets.all(0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 20.0.w),
                                    // helperText: 'ss',
                                    // errorStyle: TextStyle(fontSize: 4),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    // isDense: true,
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return LocaleKeys
                                          .pleaseSelectClientValidationMsg
                                          .tr();
                                    }
                                    return null;
                                  },
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 18.w),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xff6fc4db),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: dropdownValue,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.w500,
                                      color: Color(0xff6fc4db)),
                                  items: clientNames
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          clientNames.isNotEmpty ? value : null,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 27.w),
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: const Color(0xff6fc4db),
                                              fontSize: 17.sp),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      LocaleKeys.selectCustomers_txt.tr(),
                                      style: TextStyle(
                                          color: const Color(0xff6fc4db),
                                          fontSize: 17.sp),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      Helper.dropdownNames.add(value!);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Helper.customSizedBox,

                          /// list for Customers
                          Card(
                            elevation: 2,
                            child: SizedBox(
                              height: _cardList.isNotEmpty ? height * 0.18 : 0,
                              child: ScrollConfiguration(
                                behavior: const ScrollBehavior(
                                    androidOverscrollIndicator:
                                        AndroidOverscrollIndicator.glow),
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 20.h),
                                    itemCount: _cardList.length,
                                    itemBuilder: (context, index) {
                                      // widget.customerNames =
                                      //     Helper.dropdownNames[index];
                                      return (_cardList[index]);
                                    }),
                              ),
                            ),
                          ),

                          Helper.customSizedBox,
                          Helper.customSizedBox,
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: Text(
                              '${LocaleKeys.invoiceDate_txt.tr()}: ${Helper.getCurrentDate(context)}',
                              style: myStyle,
                            ),
                          ),
                          Helper.customSizedBox,

                          Helper.customSizedBox,
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: Text(
                              '${LocaleKeys.invoice_number_txt.tr() + "\t#"} : ${ControllersTextFields.instance.invoiceNoController.text}',
                              style: myStyle,
                            ),
                          ),
                          Helper.customSizedBox,

                          /// ===================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.08),
                                child: Text(
                                  LocaleKeys.selectWorkers_txt.tr(),
                                  style: myStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.31),
                                child: TextButton(
                                  onPressed: () {
                                    _addCardWidgetForWorkers(
                                        width, date, format, height);

                                    /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------

                                    //In each button onPressed/onTap
                                    controller.animateTo(3000,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease);

                                    /// --------------------------SCROLL AUTOMATIC BASED ON OFFSET-------------------------------------------
                                  },
                                  child: Text(
                                    LocaleKeys.AddWorker.tr(),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Helper.customSizedBox,

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                      0xff6fc4db), // red as border color
                                ),
                                color: const Color(0xff6fc4db).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              width: 400.w,

                              // padding: const EdgeInsets.all(0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 20.0.w),
                                    // helperText: 'ss',
                                    // errorStyle: TextStyle(fontSize: 4),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    // isDense: true,
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return LocaleKeys
                                          .pleaseSelectClientValidationMsg
                                          .tr();
                                    }
                                    return null;
                                  },
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 18.w),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xff6fc4db),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: dropdownValue2,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.w500,
                                      color: Color(0xff6fc4db)),
                                  items: workerNames
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          workerNames.isNotEmpty ? value : null,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 27.w),
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: const Color(0xff6fc4db),
                                              fontSize: 17.sp),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      LocaleKeys.selectWorkers_txt.tr(),
                                      style: TextStyle(
                                          color: const Color(0xff6fc4db),
                                          fontSize: 17.sp),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      Helper.dropdownNamesForWorkers
                                          .add(value!);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Helper.customSizedBox,

                          Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: Text(
                              '${LocaleKeys.week_ending_date.tr()}: ',
                              style: myStyle,
                            ),
                          ),
                          Helper.customSizedBox,

                          Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: SizedBox(
                              width: width * 0.88,
                              // height: height * 0.07,
                              child: Theme(
                                data: ThemeData.light().copyWith(
                                    primaryColor: Color(Constants.lightgreen),
                                    buttonTheme: const ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                    colorScheme: ColorScheme.light(
                                            primary:
                                                Color(Constants.lightgreen))
                                        .copyWith(
                                            secondary:
                                                Color(Constants.lightgreen))),
                                child: DateTimeField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (values) {
                                    if (values == null) {
                                      return LocaleKeys.pleaseEnterDateMsg_text
                                          .tr();
                                    }
                                    return null;
                                  },
                                  resetIcon: null,
                                  onChanged: (value) {
                                    setState(() {
                                      date.weekEndingDateMethod(value);
                                      if (kDebugMode) {
                                        print(date.weekEndingDate);
                                      }
                                    });
                                  },
                                  format: format,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                  cursorColor: Color(Constants.lightgreen),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(Constants.lightgreen),
                                  ),
                                  decoration: InputDecoration(
                                    // counterText: ' ',
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.1),
                                      borderSide: BorderSide(
                                        width: 1.w,
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.1),
                                    ),
                                    hintText: LocaleKeys.date_txt.tr(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: width * 0.06),
                                    hintStyle: TextStyle(
                                        color: Color(Constants.lightgreen),
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 17.sp),
                                    fillColor: Color(Constants.feildColor),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(Constants.lightgreen)),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(Constants.lightgreen)),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.06),
                            child: TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const SelectCategoriesScreen(),
                                  )),
                              child: Text(
                                LocaleKeys.selectCategories_txt.tr(),
                                style: const TextStyle(
                                  color: Color(0xff4C78BC),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          Helper.customSizedBox,
                          //-------------------------------------------------------------------------
                          // getSpace(context),
                          //-------------------------------------------------------------------------

                          /// list for Workers
                          Card(
                            elevation: 2,
                            child: SizedBox(
                              height: _cardListForWorkers.isNotEmpty
                                  ? height * 0.35
                                  : 0,
                              child: ScrollConfiguration(
                                behavior: const ScrollBehavior(
                                    androidOverscrollIndicator:
                                        AndroidOverscrollIndicator.glow),
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 20.h),
                                    itemCount: _cardListForWorkers.length,
                                    itemBuilder: (context, index) {
                                      return (_cardListForWorkers[index]);
                                    }),
                              ),
                            ),
                          ),
                          Helper.customSizedBox,

                          Helper.customSizedBox,
                        ],
                      ),
                    ))
                : Container(
                    height: 1.sh,
                    width: 1.sw,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${LocaleKeys.receiver_name_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    /*  for (int i = 0;
                                        i < Helper.dropdownNames.length;
                                        i++)
                                      Text(Helper.dropdownNames[i]),*/
                                    SizedBox(
                                      height: 20.h,
                                      width: 200.w,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: Helper.dropdownNames.length,
                                        itemBuilder: (context, index) {
                                          return Helper.dropdownNames.isNotEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      2.w, 0, 0, 0),
                                                  child: TextScroll(
                                                    Helper.dropdownNames[index],
                                                    mode:
                                                        TextScrollMode.bouncing,
                                                    velocity: const Velocity(
                                                        pixelsPerSecond:
                                                            Offset(150, 0)),
                                                    delayBefore: const Duration(
                                                        milliseconds: 500),
                                                    numberOfReps: 5,
                                                    pauseBetween:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    // style: const TextStyle(
                                                    //     color: Colors.green),
                                                    textAlign: TextAlign.right,
                                                    // selectable: true,
                                                  ),
                                                )
                                              : const SizedBox();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.workerName.tr()}: ",
                                      style: myStyle,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                      width: 215.w,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: Helper
                                              .dropdownNamesForWorkers.length,
                                          itemBuilder: (context, index) {
                                            return Helper
                                                    .dropdownNamesForWorkers
                                                    .isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2.w, 0, 0, 0),
                                                    child: TextScroll(
                                                      Helper.dropdownNamesForWorkers[
                                                          index],
                                                      mode: TextScrollMode
                                                          .bouncing,
                                                      velocity: const Velocity(
                                                          pixelsPerSecond:
                                                              Offset(150, 0)),
                                                      delayBefore:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      numberOfReps: 5,
                                                      pauseBetween:
                                                          const Duration(
                                                              milliseconds: 50),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  )
                                                : const SizedBox();
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.invoice_number_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(
                                      ControllersTextFields
                                          .instance.invoiceNoController.text,
                                    ),
                                    // Text("81230"),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.invoiceDate_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(
                                      Helper.getCurrentDate(context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.week_ending_date.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now())),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.description_txt.tr()}: ",
                                      style: myTotalStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                /* Row(
                                  children: [
                                    for (int i = 0;
                                        i < Helper.strListOfCategories.length;
                                        i++)
                                      Text(
                                        // "Demolition: 150",
                                        '${Helper.strListOfCategories[i].discription}: ${Helper.strListOfCategories[i].amtBilled}',
                                        // style: myStyle,
                                      ),
                                  ],
                                ),*/

                                Container(
                                  color: Colors.transparent,
                                  height: height,
                                  width: 310.w,
                                  child: ScrollConfiguration(
                                    behavior: const ScrollBehavior(
                                        androidOverscrollIndicator: null),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 20.h),
                                        itemCount:
                                            Helper.strListOfCategories.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${Helper.strListOfCategories[index].discription}: ${Helper.strListOfCategories[index].amtBilled}',
                                                    // style: myStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: isClicked == false
                ? SizedBox(
                    height: 100.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomContainerButton(
                                  text: LocaleKeys.create_invoice_txt.tr(),
                                  onPressed: () async {
                                    // Helper.strListOfCategories
                                    for (int i = 0;
                                        i < _cardListForWorkers.length;
                                        i++) {
                                      // here
                                      if (_cardListForWorkers.length ==
                                          Helper.strListOfCategories.length) {
                                        log("Equals==> " +
                                            Helper.strListOfCategories[i]
                                                .discription);
                                      }
                                    }

                                    // generate pdf file

                                    if (_formKey.currentState!.validate()) {
                                      // ====================================================
                                      setState(() {
                                        isClicked = true;
                                      });
                                      // var indexx;
                                      // // generate pdf file
                                      // for (indexx = 0;
                                      //     indexx < dataModelForInvoice.length;
                                      //     indexx++) {
                                      ///=======================================================
                                      // HelpergetTimeDifference = await getDifference(
                                      // _startTimePickerControllers[indexx].text,
                                      // _endTimePickerControllers[indexx].text);

                                      ///=======================================================

                                      // dataModelForInvoice.add(
                                      //   DataModelForInvoice(
                                      //     widget.customerNames,
                                      //     Provider.of<DataProviders>(context,
                                      //         listen: false),
                                      //   ),
                                      // );

                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   CupertinoPageRoute(
                                      //     builder: (context) =>
                                      //         InvoicePreviewScreen(
                                      //       // dataModelForInvoice,
                                      //       showDate:
                                      //           Provider.of<DataProviders>(
                                      //                   context,
                                      //                   listen: false)
                                      //               .weekEndingDate,
                                      //       decription: widget.customerNames,
                                      //     ),
                                      //   ),
                                      // );
                                      // final pdfFile =
                                      //     await PdfInvoiceApiForInvoice.generate(
                                      //         invoiceNo: ControllersTextFields
                                      //             .instance.invoiceNoController.text,
                                      //         weekEndingDate: widget.weekEndingDate);
                                      //
                                      // // opening the pdf file
                                      //
                                      // FileHandleApiForInvoice.openFile(pdfFile);
                                      // ====================================================

                                      final name = Helper.dropdownNames;
                                      final invoiceNo = ControllersTextFields
                                          .instance.invoiceNoController.text;
                                      final date = Provider.of<DataProviders>(
                                          context,
                                          listen: false);

                                      final user = PreviousInvoicesModel(
                                        name: name,
                                        invoiceNo: invoiceNo,
                                        dateTime: date.weekEndingDate,
                                      );

                                      createInvoice(user);
                                    }
                                  }
                                  // }),
                                  // SizedBox(
                                  //   height: 40.h,
                                  // ),
                                  // CustomContainerButton(
                                  //   text: LocaleKeys.enter_work_description.tr(),
                                  //   onPressed: () => Navigator.pushReplacement(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //       builder: (context) => const EditWorkDescription(),
                                  //     ),
                                  //   ),
                                  //   isActive: false,
                                  // ),
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 100.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomContainerButton(
                                  text: LocaleKeys.downloadInvoice_text.tr(),
                                  onPressed: () async {
                                    // Helper.dropdownNames.clear();
                                    // Helper.dropdownNamesForWorkers.clear();
                                    dataModelForInvoice.clear();

                                    ///
                                    ///
                                    ///
                                    // for (var element
                                    //     in distinctIdsfordropdownNamesForWorkers) {
                                    //   for (var i = 0;
                                    //       i <
                                    //           distinctIdsfordropdownNamesForWorkers
                                    //               .length;
                                    //       i++) {
                                    ///
                                    dataModelForInvoice.add(DataModelForInvoice(
                                      DateTime.now(),
                                      distinctIdsfordropdownNamesForWorkers,
                                      ControllersTextFields
                                          .instance.invoiceNoController.text,
                                      // element.toString(),
                                      3,
                                      checkBoxSettingsForCategoriesModel
                                          .toList(),
                                    ));

                                    // ===========================================================================Add DataForCategoriesModel
                                    checkBoxSettingsForCategoriesModel
                                        .add(CheckBoxSettingsForCategoriesModel(
                                            "22",
                                            [1, 3, 4],
                                            '''Full Day Work,
                                    
Full Day Work''',
                                            list.sum));

                                    ///
                                    ///
                                    // generate pdf file

                                    final pdfFile = await PdfInvoiceApiForInvoice.generate(
                                        dataModelForInvoice,
                                        checkBoxSettingsForCategoriesModel

                                        // weekEndingDate:
                                        //     dataModelForInvoice.first.weekEndingDate,
                                        // name: dataModelForInvoice.first.name,
                                        // description: dataModelForInvoice.first.name,
                                        // amountBilled: dataModelForInvoice.first.name,
                                        // invoiceNo: ControllersTextFields

                                        //     .instance.invoiceNoController.text,
                                        // workerLength: element.length,
                                        );

                                    // opening the pdf file
                                    setState(() {
                                      FileHandleApiForInvoice.openFile(pdfFile);
                                    });
                                    // }
                                  }
                                  // },
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  Future createInvoice(PreviousInvoicesModel user) async {
    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(true);

    /// Reference to document
    final docUser =
        FirebaseFirestore.instance.collection('previousInvoice').doc();
    user.id = docUser.id;

    final json = user.toJson();

    /// Create document and write data to Firebase
    await docUser.set(json);

    if (mounted) {
      return Provider.of<DataProviders>(context, listen: false)
          .isTrueOrFalseFunctionProgressHUD(false);
    }

    log(json.toString());
    if (mounted) {
      Helper.showSnackBar(
          msg: LocaleKeys.invoiceCreatedSuccessfully_txt.tr(),
          context: context);
    }

    Future.delayed(const Duration(seconds: 4)).then((value) {
      // Navigator.pushReplacement(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (context) => const InvoicePreviewScreen(),
      //     ));a
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Widget getSpace(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.2,
  );
}
