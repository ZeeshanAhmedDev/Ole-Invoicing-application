import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectProfessionView/selectProfessionModel.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../custom_widgets/appbar_with_title.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/helper.dart';
import '../../../utils/string_resource.dart';
import '../../menu_screen.dart';
import '../InvoiceScreens/create_invoice_screen.dart';
import '../SelectCategories/selectCategoriesModel.dart';
import '../SelectClientScreen/select_client_screen.dart';

import '../TimeSheetScreen/time_sheet_screen.dart';

class SelectWhatToCreateScreen extends StatefulWidget {
  const SelectWhatToCreateScreen({Key? key}) : super(key: key);

  @override
  _SelectWhatToCreateScreenState createState() =>
      _SelectWhatToCreateScreenState();
}

class _SelectWhatToCreateScreenState extends State<SelectWhatToCreateScreen> {
  List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
      [];

  final _formKey = GlobalKey<FormState>();

  final checkTextList = [
    CheckBoxSettingsModel(title: 'Construction'),
    CheckBoxSettingsModel(title: 'Landscaping'),
    CheckBoxSettingsModel(title: 'Delivery / Trash Pickup'),
    CheckBoxSettingsModel(title: 'Housekeeping'),
    CheckBoxSettingsModel(title: 'Caregiving'),
    CheckBoxSettingsModel(title: 'Caregiving'),
  ];
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
          backgroundColor: Colors.white,
          appBar: CustomAppBarWithTitle(
            fun: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MenuScreen(),
                )),
            elevation: 0,
            title: LocaleKeys.select_what_to_create_txt.tr(),
          ),
          body: Container(
              color: Colors.white10,
              height: 1.sh,
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Helper.customSizedBox,
                    Helper.customSizedBox,
                    myWidget(
                      height: height,
                      text: LocaleKeys.justTimesheetText.tr(),
                      picPath: "assets/svg_images/note.svg",
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SelectClientScreen(),
                          )),
                    ),
                    Helper.customSizedBox,
                    Helper.customSizedBox,
                    Helper.customSizedBox,
                    myWidget(
                      height: height,
                      text: LocaleKeys.justInvoiceText.tr(),
                      picPath: "assets/svg_images/calendar.svg",
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CreateInvoiceScreenNew(
                              checkBoxSettingsForCategoriesModel),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          bottomNavigationBar: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomContainerButton(
                        text: LocaleKeys.cancel_txt.tr(),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const MenuScreen(),
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

  Widget buildCheckBox({
    required CheckBoxSettingsModel settingsModel,
    required Function() onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        // onTap: () {
        //   // setState(() {
        //   //   this.value = !value;
        //   //   if (kDebugMode) {
        //   //     print(this.value);
        //   //   }
        //   // });
        // },
        leading: Checkbox(
          activeColor: Color(0xff61ACBE),
          value: settingsModel.value,
          onChanged: (bool? value) => onClicked(),
          // {
          // setState(() {
          //   this.value = value!;
          //   if (kDebugMode) {
          //     print(this.value);
          //   }
          // });
          // },
        ),
        title: Text(settingsModel.title),
      );

  Widget myWidget(
      {required double height,
      required String picPath,
      required String text,
      required Function() onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 256.w,
        height: 182.86.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color(0xFFAEE9F7),
                Color(0xFF6FC4DB),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(14.63.r),
          color: Colors.red,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 220.w, bottom: 30.h),
              child: Row(children: [
                MyTooltip(
                  message:
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
                  child: Material(
                    color: Colors.grey.shade800,
                    shape: const CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.priority_high,
                        size: 8.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            SvgPicture.asset(
              picPath,
              height: height * 0.07,
            ),
            SizedBox(height: 12.h),
            Text(
              text,
              style: TextStyle(
                color: const Color(0xFFffffff),
                fontSize: 25.h,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
