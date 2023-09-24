import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MenuContainerWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;
  final String text;
  final String textNumber;

  const MenuContainerWidget({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    required this.text,
    required this.textNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 146.66.w,
        height: 136.46.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff9e7acbe0).withOpacity(0.62),
                blurRadius: 32,
                offset: const Offset(0, 8),
                // box-shadow: 0px 8px 32px 0px #7ACBE09E;
              ),
            ],
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xff6FC4DB),
                Color(0xff6FC4DB)
              ], // red to yellow
              // tileMode: TileMode
              //     .repeated, // repeats the gradient over the canvas
            ),
            border: Border.all(color: const Color(0xff6FC4DB)),
            borderRadius: BorderRadius.circular(13.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset(imageUrl),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 72.0.w),
                      child: Material(
                        color: Colors.grey.shade800,
                        shape: const CircleBorder(),
                        elevation: 2.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Text(
                            textNumber,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            softWrap: true,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      // child: Text(
                      //   textNumber,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 22.sp,
                      //       fontWeight: FontWeight.w500),
                      //   softWrap: true,
                      //   maxLines: 1,
                      // ),
                    )
                  ],
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.68.sp,
                          fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 6,
                    ),
                  ),
                  width: 103.89.w,
                  height: 75.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
