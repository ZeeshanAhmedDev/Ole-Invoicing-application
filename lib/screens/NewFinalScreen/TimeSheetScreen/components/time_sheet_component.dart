import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Provider.dart';
import '../../../../custom_widgets/textFeild.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/constant.dart';

/// ====================================== ///
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();

var getStartTime;
var getEndTime;

final textStyle = TextStyle(
  color: Color(Constants.lightgreen),
  // fontSize:
);

/// ====================================== ///
class TimeSheetComponent extends StatefulWidget {
  TimeSheetComponent({
    Key? key,
    required TextEditingController hourlyRateController,
    required TextEditingController nameController,
    required TextEditingController startDateController,
    required TextEditingController endDateController,
    required TextEditingController descController,
  })  : _hourlyRateController = hourlyRateController,
        _nameController = nameController,
        _descController = descController,
        getStartTime = descController,
        getEndTime = descController,
        super(key: key);

  final TextEditingController _hourlyRateController;
  final TextEditingController _nameController;
  final TextEditingController _descController;
  var getStartTime;
  var getEndTime;

  @override
  State<TimeSheetComponent> createState() => _TimeSheetComponentState();
}

class _TimeSheetComponentState extends State<TimeSheetComponent> {
  @override
  Widget build(BuildContext context) {
    //====================================================
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final format = DateFormat("dd-MM-yy");
    final date = Provider.of<DataProviders>(context);

    //====================================================
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.addHourlyRate_txt.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 10.w),
              textField(
                "\$",
                120.w,
                controller: widget._hourlyRateController,
                maximumLength: 10,
                keyboardType: TextInputType.name,
                isBorderRadius: true, validatorr: null,
                // focusNode: Constants.focusNodeEmailLogin,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: textField(
                  LocaleKeys.name_txt.tr(),
                  120.w,
                  controller: widget._nameController,
                  maximumLength: 10,
                  keyboardType: TextInputType.name,
                  isBorderRadius: true, validatorr: null,
                  // focusNode: Constants.focusNodeEmailLogin,
                ),
              ),
              Expanded(
                child: SizedBox(
                    width: width * 0.62,
                    height: height * 0.07,
                    child: Theme(
                      data: ThemeData.light().copyWith(
                          primaryColor: Color(Constants.lightgreen),
                          buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary,
                          ),
                          colorScheme: ColorScheme.light(
                                  primary: Color(Constants.lightgreen))
                              .copyWith(
                                  secondary: Color(Constants.lightgreen))),
                      child: DateTimeField(
                        resetIcon: null,
                        onChanged: (value) {
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
                        cursorColor: Color(Constants.lightgreen),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(Constants.lightgreen)),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: width * 0.06),
                          hintStyle: TextStyle(
                              color: Color(Constants.lightgreen),
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 17.sp),
                          fillColor: Color(Constants.feildColor),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(Constants.lightgreen)),
                            borderRadius: BorderRadius.circular(height * 0.1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(Constants.lightgreen)),
                            borderRadius: BorderRadius.circular(height * 0.1),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: Container(
                    alignment: Alignment.center,
                    width: 120.w,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Color(Constants.lightgreen).withOpacity(0.12),
                      border: Border.all(color: Color(Constants.lightgreen)),
                      borderRadius: BorderRadius.circular(height * 0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w, bottom: 4.h),
                      child: getStartTime == null
                          ? Text(
                              LocaleKeys.start_txt.tr(),
                              style: textStyle,
                            )
                          : Text(
                              getStartTime.toString(),
                              style: textStyle,
                            ),
                    ),
                    // child: textField(
                    //   "Start",
                    //   120.w,
                    //   controller: widget._startDateController,
                    //   maximumLength: 10,
                    //   keyboardType: TextInputType.name,
                    //   isBorderRadius: true,
                    //   validatorr: null,
                    //   isReadOnly: true,
                    // ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => _selectTimeForEnd(context),
                  child: Container(
                    alignment: Alignment.center,
                    width: 120.w,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Color(Constants.lightgreen).withOpacity(0.12),
                      border: Border.all(color: Color(Constants.lightgreen)),
                      borderRadius: BorderRadius.circular(height * 0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w, bottom: 4.h),
                      child: getEndTime == null
                          ? Text(
                              LocaleKeys.end_txt.tr(),
                              style: textStyle,
                            )
                          : Text(
                              getEndTime.toString(),
                              style: textStyle,
                            ),
                    ),
                    // child: textField(
                    //   "Start",
                    //   120.w,
                    //   controller: widget._startDateController,
                    //   maximumLength: 10,
                    //   keyboardType: TextInputType.name,
                    //   isBorderRadius: true,
                    //   validatorr: null,
                    //   isReadOnly: true,
                    // ),
                  ),
                ),
              ),
              // Expanded(
              //   child: textField(
              //     "End",
              //     120.w,
              //     controller: widget._endDateController,
              //     maximumLength: 10,
              //     keyboardType: TextInputType.name,
              //     isBorderRadius: true,
              //     validatorr: null,
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Color(Constants.lightgreen),
            inputFormatters: [
              Constants.disableEmojiFromTextField,
            ],
            maxLength: 100,
            style:
                TextStyle(fontSize: 17.sp, color: Color(Constants.lightgreen)),
            controller: widget._descController,
            decoration: InputDecoration(
              hintText: LocaleKeys.description_txt.tr(),
              hintStyle: TextStyle(
                color: const Color(0xFF78CDE1),
                textBaseline: TextBaseline.alphabetic,
                fontSize: 17.sp,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 3.0,
                horizontal: 11,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF78CDE1), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF78CDE1), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              fillColor: const Color(0xFFeff8f8),
              filled: true,
              counterText: '',
            ),
          ),
        )
      ],
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
