import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectProfessionView/selectProfessionModel.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../custom_widgets/appbar_with_title.dart';
import '../../../utils/helper.dart';
import '../../menu_screen.dart';
import '../SelectWhatToCreateView/select_what_to_create_screen.dart';

class SelectProfessionScreen extends StatefulWidget {
  const SelectProfessionScreen({Key? key}) : super(key: key);

  @override
  _SelectProfessionScreenState createState() => _SelectProfessionScreenState();
}

class _SelectProfessionScreenState extends State<SelectProfessionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEmpty = false;

  final checkTextList = [
    CheckBoxSettingsModel(title: 'Construction'),
    CheckBoxSettingsModel(title: 'Landscaping'),
    CheckBoxSettingsModel(title: 'Delivery / Trash Pickup'),
    CheckBoxSettingsModel(title: 'Housekeeping'),
    CheckBoxSettingsModel(title: 'Adult Care'),
    CheckBoxSettingsModel(title: 'Child Care'),
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
            title: LocaleKeys.select_profession_txt.tr(),
          ),
          body: Container(
            color: Colors.white10,
            height: 1.sh,
            width: 1.sw,
            child: ListView(
              children: [
                ...checkTextList.map(buildSingleCheckBox).toList(),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 180.h,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomContainerButton(
                        text: LocaleKeys.next_btn_text.tr(),
                        onPressed: () {
                          if (isEmpty == false) {
                            // Helper.showToast('Please select profession');
                            Helper.showToast(
                                LocaleKeys.selectProfessionMsg_txt.tr());
                          } else {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const SelectWhatToCreateScreen(),
                              ),
                            );
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

  Widget buildSingleCheckBox(CheckBoxSettingsModel settingsModel) =>
      buildCheckBox(
          settingsModel: settingsModel,
          onClicked: () {
            setState(() {
              final newValue = !settingsModel.value;
              final newtitle = settingsModel.title;
              settingsModel.value = newValue;
              if (kDebugMode) {
                print(newValue);
                print(newtitle);
              }

              if (newValue == false) {
                isEmpty = false;
                setState(() {});
              } else {
                isEmpty = true;
              }
            });
          });

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
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
                primary: false,
                title: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      );
}
