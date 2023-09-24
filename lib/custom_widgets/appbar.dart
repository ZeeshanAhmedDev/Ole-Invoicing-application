import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../translations/locale_keys.g.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  var elevation;
  final String? title;
  var leftText;
  VoidCallback? fun;
  VoidCallback? funOfLeftText;
  CustomAppBar(
      {required this.title,
      required this.fun,
      this.elevation,
      this.leftText,
      this.funOfLeftText})
      : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    ///=========================================================

    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    /// =========================================================
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: fun,
        child: Padding(
          padding: EdgeInsets.only(left: myWidth * 0.01),
          child: Container(
            color: Colors.transparent,
            child: Icon(
              Icons.arrow_back_ios,
              color: const Color(0xFF292D32),
              size: myHeight * 0.03,
            ),
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 24.42.sp,
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w700,
        ),
        overflow: TextOverflow.visible,
      ),
      actions: [
        // title != "Clients" && title != 'Workers'
        title != LocaleKeys.clients_txt.tr() &&
                title != LocaleKeys.workers_txt.tr()
            ? const SizedBox()
            : TextButton(
                onPressed: funOfLeftText,
                child: Text(leftText),
              )
        // child: title != "Clients" ? const SizedBox() : Text(leftText))
      ],
    );
  }
}
