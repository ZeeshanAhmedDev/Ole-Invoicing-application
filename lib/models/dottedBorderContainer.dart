import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DottedBorderContainer extends StatelessWidget {
//   // var VoidCallback onPressed;
//   //  final String text;
//   //  const DottedBorderContainer({
//   //    Key? key,
//   //    required this.onPressed,
//   //    required this.text,
//   //  }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {}
// }

Widget DottedBorderContainer({
  required String text,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: DottedBorder(
      color: const Color(0xff6FC4DB),
      strokeWidth: 1.w,
      dashPattern: [9],
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      padding: EdgeInsets.all(2.r),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            alignment: Alignment.center,
            height: 60.h,
            width: 368.w,
            child: GestureDetector(
              onTap: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xff6FC4DB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ),
    ),
  );
}
