import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/constant.dart';

class BuildPageOfOnBoard extends StatelessWidget {
  const BuildPageOfOnBoard({
    Key? key,
    required PageController controllerPageView,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  })  : _controllerPageView = controllerPageView,
        super(key: key);

  final String imageUrl;
  final String title;
  final String subTitle;

  final PageController _controllerPageView;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SvgPicture.asset(
            imageUrl,
            // width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 15.h,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: SvgPicture.asset(
                    'assets/svg_images/arrow-left.svg',
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controllerPageView, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 4.h,
                    dotWidth: 8.w,
                    activeDotColor: Constants.kActiveIndicatorColor,
                    dotColor: Constants.kActiveIndicatorColor.withOpacity(0.5),
                    spacing: 15.w,
                  ), //
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: SvgPicture.asset(
                    'assets/svg_images/arrow-right.svg',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 76.h,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 29.84.sp),
          ),
          SizedBox(
            height: 26.h,
          ),
          Text(
            subTitle,
            // 'Easily create an invoice in English \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t and Hispanic',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
          ),
        ],
      ),
      // child: const Center(child: Text("Page 2")),
    );
  }
}
