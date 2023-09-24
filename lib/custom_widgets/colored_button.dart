import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget colored_Button(double width, String text, VoidCallback onpressed,
    {bool active = true}) {
  return Container(
    height: 50.sp,
    width: width,
    child: ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(10.sp),
          shadowColor: active
              ? MaterialStateProperty.all<Color>(Color(0xFF78CDE1))
              : MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
          backgroundColor: active
              ? MaterialStateProperty.all<Color>(Color(0xFF78CDE1))
              : MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.sp),
          ))),
      onPressed: active ? onpressed : () {},
      // onPressed:Helper.onPressedValue ? () {} : null,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 21.sp, color: !active ? Color(0xFF78CDE1) : Colors.white),
      ),
    ),
  );
}
