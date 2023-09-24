import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: non_constant_identifier_names
Widget CustomContainerButton(
    {required String text,
    required VoidCallback onPressed,
    bool isActive = true}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 60.h,
      width: 368.w,
      decoration: BoxDecoration(
        boxShadow: [
          isActive
              ? BoxShadow(
                  color: const Color(0xffAEE9F7).withOpacity(0.62),
                  blurRadius: 32,
                  spreadRadius: 0,
                  offset: const Offset(
                    0,
                    8,
                  ),
                )
              : BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.11),
                  blurRadius: 34,
                  spreadRadius: 0,
                  offset: const Offset(
                    0,
                    14,
                  ),
                )
        ],
        gradient: isActive
            ? const LinearGradient(
                colors: [
                  Color(0xffAEE9F7),
                  Color(0xff6FC4DB),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : const LinearGradient(
                colors: [
                  Color(0xffFFFFFF),
                  Color(0xffFFFFFF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: isActive ? Colors.white : const Color(0xff6FC4DB),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
