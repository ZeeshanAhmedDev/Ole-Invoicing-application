import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constant.dart';

Widget descTextField(
  String hint,
  double width, {
  isCenter = false,
  isBorderRadius = false,
  required validatorr,
  required final controller,
  var keyboardType,
  required final maximumLength,
  var suffixtextt,
  var focusNode,
  isReadOnly = false,
}) {
  return SizedBox(
      width: width,
      // height: 400,
      child: TextFormField(
        inputFormatters: [
          Constants.disableEmojiFromTextField,
        ],
        readOnly: isReadOnly,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLength: maximumLength,
        controller: controller,
        validator: validatorr,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Color(Constants.lightgreen),
        style: TextStyle(fontSize: 17.sp, color: Color(Constants.lightgreen)),
        decoration: InputDecoration(
            counterText: '',
            errorBorder: isBorderRadius
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(55.r)),
                    // borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      width: 1.w,
                      color: Colors.red,
                    ),
                  )
                : OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      width: 1.w,
                      color: Colors.red,
                    ),
                  ),
            focusedErrorBorder: isBorderRadius
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(55.r)),
                    // borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      width: 1.w,
                      color: Colors.red,
                    ),
                  )
                : OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    borderRadius: BorderRadius.zero,
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
            contentPadding: isCenter == false
                ? EdgeInsets.only(
                    top: 18.h,
                    bottom: 18.h,
                    left: 27.w,
                  )
                : const EdgeInsets.only(top: 0),
            focusedBorder: isBorderRadius
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    borderRadius: BorderRadius.circular(55.sp),
                    // borderRadius: BorderRadius.zero,
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    // borderRadius: BorderRadius.circular(15.sp),
                    borderRadius: BorderRadius.zero,
                  ),
            enabledBorder: isBorderRadius
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    borderRadius: BorderRadius.circular(45.sp),
                    // borderRadius: BorderRadius.zero,
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: Color(Constants.lightgreen)),
                    // borderRadius: BorderRadius.circular(55.sp),
                    borderRadius: BorderRadius.zero,
                  )),
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
      ));
}
