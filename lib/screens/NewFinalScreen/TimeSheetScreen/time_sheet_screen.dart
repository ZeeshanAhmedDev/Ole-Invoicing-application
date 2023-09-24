import 'dart:developer';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectWhatToCreateView/select_what_to_create_screen.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/pdfGenerationForTimeSheet/PdfInvoiceApi.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/pdfGenerationForTimeSheet/data%20model.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/pdfGenerationForTimeSheet/fileHandler.dart';
import 'package:provider/provider.dart';
import '../../../Provider.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../custom_widgets/textFeild.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/constant.dart';
import '../../../utils/controllers.dart';
import '../../../utils/helper.dart';
import 'package:collection/collection.dart';

var dummyText;
var getIndex;
var getStartTime;
var getEndTime;
List<String> allMessages = [];

class TimeSheetScreen extends StatefulWidget {
  const TimeSheetScreen({Key? key}) : super(key: key);

  @override
  _TimeSheetScreenState createState() => _TimeSheetScreenState();
}

class _TimeSheetScreenState extends State<TimeSheetScreen> {
  @override
  void didChangeDependencies() {
    //========================================================
    Helper.time2invoiceNO =
        DateTime.now().millisecondsSinceEpoch.remainder(100000).toString();
    ControllersTextFields.instance.invoiceNoController.text =
        Helper.time2invoiceNO;

    //========================================================
    // _onPress();
    super.didChangeDependencies();
  }

  var time1 = "09:00";
  var time2 = "12:40";
  List<int> helperGetTimeDifference = [];

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _onPress();
    });
    // getDifference(time1, time2);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final hourlyRateController = MaskedTextController(mask: '000');
  final suppliesAmountController = MaskedTextController(mask: '000');
  var i;

  final myStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.sp,
  );

  final myTotalStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );

  bool isClicked = false;

  /// ====================================== ///
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  final format = DateFormat("dd-MM-yy");

  /// ====================================== ///

  //========================================================GenerateDynamicWidget
  // List<TextEditingController> _hourlyRateControllers = [];
  // List<TextFormField> _hourlyRateFields = [];

  List<DataModelForTimeSheet> dataModelForTimeSheet = [];

  /// ***********************************88*************
  List<TextEditingController> _startTimeControllers = [];
  List<DateTimeField> _startTimeFields = [];

  /// ***********************************88*************
  // List<TextEditingController> _addSuplliesAmountControllers = [];
  // List<TextFormField> _addSuplliesAmountFields = [];

  /// ***********************************88*************
  List<TextEditingController> _nameControllers = [];
  List<TextFormField> _nameFields = [];

  /// ***********************************88*************
  List<TextEditingController> _startTimePickerControllers = [];
  List<TextFormField> _startTimePickerFields = [];

  /// ***********************************88*************
  List<TextEditingController> _endTimePickerControllers = [];
  List<TextFormField> _endTimePickerFields = [];

  /// ***********************************88*************

  List<TextEditingController> _descriptionControllers = [];
  List<TextFormField> _descriptionFields = [];

  @override
  void dispose() {
    // for (final controller in _hourlyRateControllers) {
    //   controller.dispose();
    // }
    // for (final controller in _addSuplliesAmountControllers) {
    //   controller.dispose();
    // }
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    for (final controller in _descriptionControllers) {
      controller.dispose();
    }

    hourlyRateController.dispose();
    suppliesAmountController.dispose();

    ///=====================================================================
    for (final controller in _startTimeControllers) {
      controller.dispose();
    }
    for (final controller in _startTimePickerControllers) {
      controller.dispose();
    }
    for (final controller in _endTimePickerControllers) {
      controller.dispose();
    }

    ///=====================================================================
    _okController.dispose();
    super.dispose();
  }

  void _onPress() {
    /// ==========================================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    /// ==========================================================================
    // final hourlyRate = MaskedTextController(mask: '000');
    // final suppliesAmount = MaskedTextController(mask: '000');
    final name = TextEditingController();
    final description = TextEditingController();
    final startTimePicker = MaskedTextController(mask: '00:00');
    final endTimePicker = MaskedTextController(mask: '00:00');

    ///=====================================================================
    final startTime = TextEditingController();

    // final hourlyRateField =
    //     _generateTextField(hourlyRate, "Add Hourly Rate");
    // final suppliesAmountField =
    //     _generateTextField(suppliesAmount, "Supplies Amount");
    final nameField = _generateTextField(name, "Name");
    final startTimePickerField =
        _generateStartTimePickerField(startTimePicker, "Start");
    final descriptionField = _generateTextField(description, "description");

    final endTimePickerField =
        _generateENDTimePickerField(endTimePicker, "End");

    ///=====================================================================
    final startTimeField =
        _generateDateTimeField(startTime, "Start Time", height, width);

    setState(() {
      // _hourlyRateControllers.add(hourlyRate);
      // _addSuplliesAmountControllers.add(suppliesAmount);
      _startTimePickerControllers.add(startTimePicker);
      _endTimePickerControllers.add(endTimePicker);
      _nameControllers.add(name);
      _descriptionControllers.add(description);

      ///=====================================================================
      _startTimeControllers.add(startTime);
      // _startTimeControllers.add(startTime);

      // _hourlyRateFields.add(hourlyRateField);
      // _addSuplliesAmountFields.add(suppliesAmountField);
      _nameFields.add(nameField);
      _descriptionFields.add(descriptionField);
      _startTimePickerFields.add(startTimePickerField);
      _endTimePickerFields.add(endTimePickerField);

      ///=====================================================================
      _startTimeFields.add(startTimeField);
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

  TextFormField _generateTextField(
      TextEditingController controller, String hint) {
    return TextFormField(
      validator: (value) {
        if (value!.trimLeft().isEmpty) {
          return "Enter required field";
        }
        return null;
      },
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
              fontSize: 17.sp),
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
    );
  }

  TextFormField _generateStartTimePickerField(
      TextEditingController controller, String hint) {
    return TextFormField(
      validator: (value) {
        if (value!.trimLeft().isEmpty) {
          return "Enter required field";
        }
        return null;
      },
      controller: controller,
      // keyboardType: TextInputType.number,
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
              fontSize: 17.sp),
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
    );
  }

  TextFormField _generateENDTimePickerField(
      TextEditingController controller, String hint) {
    return TextFormField(
      validator: (value) {
        if (value!.trimLeft().isEmpty) {
          return "Enter required field";
        }
        return null;
      },
      controller: controller,
      // keyboardType: TextInputType.number,
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
              fontSize: 17.sp),
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
    );
  }

  DateTimeField _generateDateTimeField(TextEditingController controller,
      String hint, double height, double width) {
    return DateTimeField(
      resetIcon: null,
      onChanged: (value) {
        final date = Provider.of<DataProviders>(context, listen: false);
        date.timeSheetDateMethod(value);
      },
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
      },
      validator: (value) {
        if (value == null) {
          return "Enter required field";
        }
        return null;
      },
      cursorColor: Color(Constants.lightgreen),
      style: TextStyle(fontSize: 15.sp, color: Color(Constants.lightgreen)),
      decoration: InputDecoration(
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(height * 0.1),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(height * 0.1),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.red,
          ),
        ),
        hintText: LocaleKeys.date_txt.tr(),
        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
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
    );
  }

  Widget _listView() {
    final children = [
      for (i = 0; i < _nameControllers.length; i++)
        // for (_nameControllers.length)
        Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              // _hourlyRateFields[i],
              // Helper.customSizedBox,
              // _addSuplliesAmountFields[i],
              Helper.customSizedBox,
              _nameFields[i],
              Helper.customSizedBox,
              _descriptionFields[i],
              Helper.customSizedBox,
              _startTimeFields[i],
              //===============================
              Helper.customSizedBox,
              _startTimePickerFields[i],
              Helper.customSizedBox,
              _endTimePickerFields[i],
              Helper.customSizedBox,
            ],
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  final _okController = TextEditingController();
  Widget _okButton(BuildContext context) {
    final textField = TextField(
      controller: _okController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );

    final button = ElevatedButton(
      onPressed: () async {
        final data = Provider.of<DataProviders>(context, listen: false);
        // final index = int.parse(_okController.text);
        String text = "name: ${_nameControllers[Helper.index].text}\n" +
            "DateTime: ${data.getTimeSheetDate[1]}\n" +
            "Supplies: ${_descriptionControllers[1].text}";
        Helper.showSnackBar(context: context, msg: text);
      },
      child: const Text("OK"),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: textField,
          width: 100,
          height: 50,
        ),
        button,
      ],
    );
  }

  //========================================================GenerateDynamicWidget
  @override
  Widget build(BuildContext context) {
    //====================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final date = Provider.of<DataProviders>(context);
    //====================================================
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () => Helper.onWillPopFunc(
            context: context, className: const SelectWhatToCreateScreen()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            fun: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SelectWhatToCreateScreen(),
                )),
            elevation: 0,
            title: LocaleKeys.time_sheet_txt.tr(),
          ),

          body: isClicked == false
              ? Container(
                  color: Colors.white10,
                  height: 1.sh,
                  width: 1.sw,
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _addTile(),
                        Padding(
                          padding: EdgeInsets.only(left: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.addHourlyRate_txt.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 13.0.w),
                                child: textField(
                                  "\$",
                                  140.w,
                                  controller: hourlyRateController,
                                  maximumLength: 10,
                                  // keyboardType: TextInputType.name,
                                  isBorderRadius: true,
                                  validatorr: (value) {
                                    if (value!.trimLeft().isEmpty) {
                                      return "Enter rate";
                                    }
                                    return null;
                                  },
                                  // focusNode: Constants.focusNodeEmailLogin,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.only(left: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Supplies Amount',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: textField(
                                  "\$",
                                  140.w,
                                  controller: suppliesAmountController,
                                  maximumLength: 10,
                                  // keyboardType: TextInputType.name,
                                  isBorderRadius: true,
                                  validatorr: (value) {
                                    if (value!.trimLeft().isEmpty) {
                                      return "Enter an amount";
                                    }
                                    return null;
                                  },
                                  // focusNode: Constants.focusNodeEmailLogin,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(child: _listView()),
                        // _okButton(context),
                      ],
                    ),
                  ),
                )

              ///
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.details_txt.tr(),
                          style: myStyle,
                        ),

                        SizedBox(
                          height: 60.h,
                        ),

                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: i,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: Colors.transparent,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              // Helper.index = index;
                              if (kDebugMode) {
                                print("index  =====>  " + index.toString());
                              }
                            });

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.name_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(_nameControllers[index].text),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.startTime_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(_startTimePickerControllers[index]
                                        .text),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.endTime_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(_endTimePickerControllers[index].text),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.date_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(date.getTimeSheetDate),
                                      // "${DateTime.now()}",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.description_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(_descriptionControllers[index].text),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${LocaleKeys.time_txt.tr()}: ",
                                      style: myStyle,
                                    ),
                                    Text(helperGetTimeDifference[index]
                                        .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),

                                Helper.customSizedBox,
                                const Divider(
                                  color: Colors.grey,
                                ),
                                // Helper.customSizedBox,
                              ],
                            );
                          },
                        ),

                        // ============================
                        // Row(
                        //   children: [
                        //     Text(
                        //       "${LocaleKeys.time_txt.tr()}: ",
                        //       style: myStyle,
                        //     ),
                        //     for (var mi = 0;
                        //         mi < helperGetTimeDifference.length;
                        //         mi++)
                        //       Text(helperGetTimeDifference[mi].toString()),
                        //   ],
                        // ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.perHourRate_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text("\$${hourlyRateController.text}"),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Supplies Amount: ",
                              style: myStyle,
                            ),
                            Text("\$${suppliesAmountController.text}"),
                          ],
                        ),

                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.total_txt.tr()}: ",
                              style: myTotalStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.totalTime_txt.tr()}: ",
                              style: myStyle,
                            ),
                            // for (var mi = 0;
                            //     mi < helperGetTimeDifference.length;
                            //     mi++)
                            Text('${helperGetTimeDifference.sum}'),
                            // "${Helper.calcWorkHours(widget.startTime, widget.endTime)}"),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.totalAmount_txt.tr()}: ",
                              style: myStyle,
                            ),
                            Text("\$"
                                " ${helperGetTimeDifference.sum * int.parse(hourlyRateController.text).toInt()}"),
                          ],
                        ),
                        // ============================
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ),

          /// ================================================================== ///

          bottomNavigationBar: isClicked == false
              ? SizedBox(
                  height: 180.h,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CustomContainerButton(
                                text: LocaleKeys.next_btn_text.tr(),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      // ========================================================

                                      // ========================================================

                                      isClicked = true;

                                      for (var element in _nameControllers) {
                                        dummyText = element.text;
                                        if (kDebugMode) {
                                          print("dumm y == > " + dummyText);
                                        }
                                        return dummyText;
                                      }
                                    });

                                    for (int i = 0;
                                        i < _startTimePickerControllers.length;
                                        i++) {
                                      helperGetTimeDifference.add(
                                          await getDifference(
                                              _startTimePickerControllers[i]
                                                  .text,
                                              _endTimePickerControllers[i]
                                                  .text));
                                    }
                                    setState(() {});
                                  }

                                  ///================================================================================
                                }),
                            SizedBox(
                              height: 40.h,
                            ),
                            CustomContainerButton(
                              text: LocaleKeys.cancel_txt.tr(),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const SelectWhatToCreateScreen(),
                                    ));
                              },
                              isActive: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 180.h,
                  child: Column(
                    children: [
                      // final date = Provider.of<DataProviders>(context, listen: false);

                      Expanded(
                        child: Column(
                          children: [
                            CustomContainerButton(
                              text: LocaleKeys.downloadInvoice_text.tr(),
                              onPressed: () async {
                                dataModelForTimeSheet.clear();
                                var indexx;
                                Helper.showAllDataForEverything;

                                setState(() {});

                                // generate pdf file
                                for (indexx = 0;
                                    indexx < _nameControllers.length;
                                    indexx++) {
                                  // for (var i = 0;
                                  //     i < dataModelForTimeSheet.length;
                                  //     i++) {
                                  //   sum += dataModelForTimeSheet[i].totalTime;
                                  //   log("--------------------------> " + sum);
                                  // }
                                  // getDifference(
                                  //     _startTimePickerControllers[indexx].text,
                                  //     _endTimePickerControllers[indexx].text);
                                  ///=======================================================
                                  // HelpergetTimeDifference = await getDifference(
                                  //     _startTimePickerControllers[indexx].text,
                                  //     _endTimePickerControllers[indexx].text);

                                  ///=======================================================

                                  dataModelForTimeSheet
                                      .add(DataModelForTimeSheet(
                                    date.getTimeSheetDate,
                                    _nameControllers[indexx].text,
                                    hourlyRateController.text,
                                    _descriptionControllers[indexx].text,
                                    suppliesAmountController.text,
                                    "${helperGetTimeDifference[indexx]}",
                                    "${helperGetTimeDifference.sum}",
                                    " ${helperGetTimeDifference.sum * int.parse(hourlyRateController.text).toInt()}",
                                    ControllersTextFields
                                        .instance.invoiceNoController.text,
                                    i,
                                    _startTimePickerControllers[indexx].text,
                                    _endTimePickerControllers[indexx].text,
                                  ));

                                  final pdfFile = await PdfInvoiceApi.generate(
                                      dataModelForTimeSheet);
                                  if (kDebugMode) {
                                    print("sdsd===> " +
                                        ControllersTextFields
                                            .instance.invoiceNoController.text);
                                  }

                                  // opening the pdf file
                                  setState(() {
                                    FileHandleApi.openFile(pdfFile);
                                  });
                                  // continue;
                                }
                              },
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            CustomContainerButton(
                              text: LocaleKeys.cancel_txt.tr(),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const TimeSheetScreen(),
                                  ),
                                );
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

  //======================================================== selectedStartTime
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedStartTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Theme(
                data: ThemeData.light().copyWith(
                    primaryColor: Color(Constants.lightgreen),
                    buttonTheme: const ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    ),
                    colorScheme:
                        ColorScheme.light(primary: Color(Constants.lightgreen))
                            .copyWith(secondary: Color(Constants.lightgreen))),
                child: child!),
          );
        });

    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedStartTime = pickedTime;
        setState(() {});
      });
    }

    // Conversion logic starts here
    final tempDate = DateFormat("hh:mm").parse(
        selectedStartTime.hour.toString() +
            ":" +
            selectedStartTime.minute.toString());
    final dateFormat = DateFormat("h:mm a"); // you can change the format here
    log(dateFormat.format(tempDate));
    setState(() {
      getStartTime = dateFormat.format(tempDate);
    });
  }

  Future<int> getDifference(String time1, String time2) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    var _date = dateFormat.format(DateTime.now());

    DateTime a = DateTime.parse('$_date $time1');
    DateTime b = DateTime.parse('$_date $time2');

    log('a $a');
    log('b $a');

    log("inHours ${b.difference(a).inHours}");
    log("inMinutes ${b.difference(a).inMinutes}");
    log(" inSeconds${b.difference(a).inSeconds}");

    return b.difference(a).inHours;
  }

  //======================================================== selectedENDTime
  Future<void> _selectTimeForEnd(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedEndTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Theme(
                data: ThemeData.light().copyWith(
                    primaryColor: Color(Constants.lightgreen),
                    buttonTheme: const ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    ),
                    colorScheme:
                        ColorScheme.light(primary: Color(Constants.lightgreen))
                            .copyWith(secondary: Color(Constants.lightgreen))),
                child: child!),
          );
        });

    if (pickedTime != null && pickedTime != selectedEndTime) {
      setState(() {
        selectedEndTime = pickedTime;
      });
    }

    // Conversion logic starts here
    final tempDate = DateFormat("hh:mm").parse(selectedEndTime.hour.toString() +
        ":" +
        selectedEndTime.minute.toString());
    final dateFormat = DateFormat("h:mm a"); // you can change the format here
    log(dateFormat.format(tempDate));
    setState(() {
      getEndTime = dateFormat.format(tempDate);
    });
  }
}
