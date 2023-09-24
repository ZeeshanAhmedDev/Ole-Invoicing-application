import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ole_app/screens/menu_screen.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../custom_widgets/textFeild.dart';
import '../../../utils/string_resource.dart';
import '../Provider.dart';
import '../custom_widgets/multi_select_dropdown.dart';
import '../models/previous_invoice_Model.dart';
import '../translations/locale_keys.g.dart';
import '../utils/constant.dart';
import '../utils/controllers.dart';
import '../utils/helper.dart';
import '../models/dottedBorderContainer.dart';
import 'edit_workDescription.dart';

class CreateInvoiceScreen extends StatefulWidget {
  var appBarName;
  CreateInvoiceScreen(
    this.appBarName, {
    Key? key,
  }) : super(key: key);

  @override
  _CreateInvoiceScreenState createState() => _CreateInvoiceScreenState();
}

//======================================================================
final workerNameController = TextEditingController();
//======================================================================

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  void _showMultiSelect() async {
    final List<String> _items = [
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'MySQL'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        Helper.selectedItems = results;
      });
    } else {
      log("please select value");
    }
  }

  //========================================================GenerateDynamicWidget
  void _addCardWidget() {
    setState(() {
      Helper.listForDynamicWidgets.add(_card());
    });
  }

  Widget _card() {
    return Container(
      alignment: Alignment.center,
      width: 368.w,
      height: 251.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: const Color(0xffC4C4C4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: 348.w,
            height: 110.64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.46.r),
              color: const Color(0xffE9E9E9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Select Job'),
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.1),
                      thickness: 2,
                    ),
                    const Text('Worked Date'),
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.1),
                      thickness: 2,
                    ),
                    const Text('Select Description'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: workerNameController,
                        inputFormatters: [
                          Constants.disableEmojiFromTextField,
                        ],
                        cursorColor: Color(Constants.lightgreen),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(Constants.lightgreen)),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.1),
                      thickness: 2,
                    ),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          Constants.disableEmojiFromTextField,
                        ],
                        cursorColor: Color(Constants.lightgreen),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(Constants.lightgreen)),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.1),
                      thickness: 2,
                    ),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          Constants.disableEmojiFromTextField,
                        ],
                        cursorColor: Color(Constants.lightgreen),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(Constants.lightgreen)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.center,
            width: 348.w,
            height: 110.64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.46.r),
              color: const Color(0xffE9E9E9),
            ),
          ),
        ],
      ),
    );
  }

  //========================================================GenerateDynamicWidget

  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy");

  @override
  void dispose() {
    // ControllersTextFields.instance.clientInvoiceDateController.dispose();
    // ControllersTextFields.instance.invoiceNoController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //========================================================
    Helper.time =
        DateTime.now().millisecondsSinceEpoch.remainder(100000).toString();
    ControllersTextFields.instance.invoiceNoController.text = Helper.time;
    //========================================================
    super.didChangeDependencies();
  }

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
            builder: (context) => const MenuScreen(),
          ));
      return Future.value(false);
    }
    return Future.value(true);
  }
  //===================================END

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
            context: context, className: const MenuScreen()),
        child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: CustomAppBar(
              title: widget.appBarName ?? '',
              fun: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    // builder: (context) => InvoicesScreen("Previous Invoices"),
                    builder: (context) => const MenuScreen(),
                  )),
              elevation: 0),
          body: Container(
            color: Colors.white10,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        LocaleKeys.client_name_txt.tr(),
                        // StringResource.SignIn,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // Client Name MultiDropDown
                      GestureDetector(
                        onTap: _showMultiSelect,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 368.w,
                          height: 60.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.w),
                            child: GestureDetector(
                              onTap: _showMultiSelect,
                              child: Text(
                                'Select Clients',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xff6fc4db),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff6fc4db)),
                            color: Color(Constants.lightgreen).withOpacity(0.1),
                          ),
                        ),
                      ),

                      // Wrap(
                      //   children: Helper.selectedItems
                      //       .map(
                      //         (e) => Chip(label: Text(e)),
                      //       )
                      //       .toList(),
                      // ),

                      // Container(
                      //   decoration: BoxDecoration(

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Invoice Date",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      textField(
                        Helper.getCurrentDate(context),
                        368.w,
                        validatorr: (value) {
                          return null;
                        },
                        isReadOnly: true,
                        controller: ControllersTextFields
                            .instance.clientInvoiceDateController,
                        maximumLength: 60,
                        keyboardType: TextInputType.streetAddress,
                        // focusNode: Constants.focusNodeEmailLogin,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        // "Invoice #",
                        LocaleKeys.invoice_number_txt.tr() + "\t#",
                        // StringResource.SignIn,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      textField(
                        '',
                        368.w,
                        validatorr: (value) {
                          if (value.isEmpty) {
                            return StringResource.enterValidEmailMessage;
                          }

                          // if ((!Constants.regExpForEmail
                          //     .hasMatch(userNameControllerLogin.text))) {
                          //   return StringResource.enterValidEmailMessage;
                          // }
                          return null;
                        },
                        isReadOnly: true,
                        controller:
                            ControllersTextFields.instance.invoiceNoController,
                        maximumLength: 60,
                        keyboardType: TextInputType.streetAddress,
                        // focusNode: Constants.focusNodeEmailLogin,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        // "Week Ending date",
                        LocaleKeys.week_ending_date.tr(),
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      SizedBox(
                          width: 368.w,
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                primaryColor: Color(Constants.lightgreen),
                                buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary,
                                ),
                                colorScheme: ColorScheme.light(
                                        primary: Color(Constants.lightgreen))
                                    .copyWith(
                                        secondary:
                                            Color(Constants.lightgreen))),
                            child: DateTimeField(
                              resetIcon: Icon(Icons.cancel,
                                  color: Color(Constants.lightgreen)),
                              onChanged: (value) {
                                Helper.showDateOfCalender = value;
                                log(Helper.showDateOfCalender.toString());
                                setState(() {});
                              },
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    // firstDate: DateTime(1900),
                                    // initialDate: currentValue ?? DateTime.now(),
                                    // lastDate: DateTime(2200));
                                    initialDate: currentValue ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    // .subtract(const Duration(days: 1)),
                                    lastDate: DateTime(2100));
                              },
                              cursorColor: Color(Constants.lightgreen),
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Color(Constants.lightgreen)),
                              decoration: InputDecoration(
                                counterText: '',
                                errorBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                ),
                                hintText: '   Select Date',
                                hintStyle: TextStyle(
                                    color: Color(Constants.lightgreen),
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 17.sp),
                                fillColor: Color(Constants.feildColor),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(Constants.lightgreen)),
                                  // borderRadius: BorderRadius.circular(15.sp),
                                  borderRadius: BorderRadius.zero,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(Constants.lightgreen)),
                                  // borderRadius: BorderRadius.circular(15.sp),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          )),

                      // InkWell(
                      //   child: Container(
                      //     width: 368.w,
                      //     height: 55.h,
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xff6FC4DB).withOpacity(0.15),
                      //       borderRadius: BorderRadius.circular(13.r),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //         right: width * 0.06,
                      //         // bottom: width * 0.01,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.only(
                      //               left: width * 0.07,
                      //             ),
                      //             child: Text(
                      //               StringResource.selectDateDuration,
                      //               style: TextStyle(
                      //                   color: Colors.black45,
                      //                   fontSize: height * 0.016),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(
                      //                 // right: width * 0.01,
                      //                 // left: width * 0.09,
                      //                 // top: 10,
                      //                 ),
                      //             child: SvgPicture.asset(
                      //                 'assets/svg_images/calendar.svg',
                      //                 fit: BoxFit.contain,
                      //                 height: 43.h,
                      //                 color: Color(0xff6FC4DB)
                      //                 // alignment: Alignment.centerRight,
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     showGeneralDialog(
                      //         context: context,
                      //         barrierDismissible: true,
                      //         barrierLabel: MaterialLocalizations.of(context)
                      //             .modalBarrierDismissLabel,
                      //         barrierColor: Colors.black54,
                      //         transitionDuration:
                      //             const Duration(milliseconds: 500),
                      //         pageBuilder: (BuildContext buildContext,
                      //             Animation animation,
                      //             Animation secondaryAnimation) {
                      //           return AlertDialog(
                      //               title: const Text(
                      //                 'Select Date Interval',
                      //                 style: TextStyle(fontSize: 20),
                      //               ),
                      //               content: Container(
                      //                 width: width / 1.3,
                      //                 height: 300,
                      //                 child: Column(
                      //                   children: <Widget>[
                      //                     Container(
                      //                         height: 250,
                      //                         child: Card(
                      //                             child: SfDateRangePicker(
                      //                           selectionMode:
                      //                               DateRangePickerSelectionMode
                      //                                   .range,
                      //                           view: DateRangePickerView.month,
                      //                           onSelectionChanged:
                      //                               _onSelectionChanged,
                      //                           startRangeSelectionColor:
                      //                               const Color(0xFF58C1C0)
                      //                                   .withOpacity(0.8),
                      //                           endRangeSelectionColor:
                      //                               const Color(0xFF58C1C0)
                      //                                   .withOpacity(0.8),
                      //                           selectionTextStyle:
                      //                               const TextStyle(
                      //                                   color: Colors.white),
                      //                           rangeSelectionColor:
                      //                               const Color(0xFF58C1C0),
                      //                           monthViewSettings:
                      //                               const DateRangePickerMonthViewSettings(
                      //                                   weekendDays: <int>[
                      //                                 DateTime.sunday,
                      //                                 DateTime.saturday
                      //                               ]),
                      //                         ))),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceEvenly,
                      //                       children: [
                      //                         MaterialButton(
                      //                           child: const Text("Cancel"),
                      //                           onPressed: () {
                      //                             Navigator.pop(context);
                      //                           },
                      //                         ),
                      //                         MaterialButton(
                      //                           child: const Text("OK"),
                      //                           onPressed: () {
                      //                             Navigator.pop(context);
                      //                           },
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ));
                      //         });
                      //   },
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),

                      Helper.listForDynamicWidgets.isNotEmpty
                          ? Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.all(5.0.r),
                              // height: 295.0.h,
                              width: 355.0.w,
                              child: Container(
                                // height: 400.h,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        // thickness: 2,
                                        color: Colors.transparent,
                                        height: 40.h,
                                      );
                                    },
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        Helper.listForDynamicWidgets.length,
                                    itemBuilder: (context, index) {
                                      return Helper
                                          .listForDynamicWidgets[index];
                                    }),
                              ),
                            )
                          : SizedBox(
                              height: 80.h,
                            ),

                      SizedBox(
                        height: 40.h,
                      ),

                      DottedBorderContainer(
                          // text: 'Add Description',
                          text: LocaleKeys.add_description_txt.tr(),
                          onPressed: () {
                            _addCardWidget();
                            // Helper.listForDynamicWidgets.clear();
                            // log("Add Description button is Pressed");
                            setState(() {});
                          }),

                      SizedBox(
                        height: 240.h,
                      ),
                      //
                      // Container(
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 40.h,
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 180.h,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomContainerButton(
                        // text: StringResource.createInvoice,
                        text: LocaleKeys.create_invoice_txt.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = Helper.selectedItems;
                            final invoiceNo = ControllersTextFields
                                .instance.invoiceNoController.text;

                            final user = PreviousInvoicesModel(
                              name: name,
                              invoiceNo: invoiceNo,
                              dateTime: DateTime.now(),
                            );

                            createInvoice(user);
                          }
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomContainerButton(
                        // text: StringResource.enterWorkDescription,
                        text: LocaleKeys.enter_work_description.tr(),
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
                ),
              ],
            ),
          ),
        ),
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

    Provider.of<DataProviders>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(false);

    log(json.toString());
    Helper.showSnackBar(msg: 'Invoice created successfully.', context: context);
    Future.delayed(const Duration(seconds: 4)).then((value) {
      // Navigator.pushReplacement(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (context) => const InvoicePreviewScreen(),
      //     ));
    });
  }
}
