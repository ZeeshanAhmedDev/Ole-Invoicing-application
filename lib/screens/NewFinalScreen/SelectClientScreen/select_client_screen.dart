import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/screens/NewFinalScreen/TimeSheetScreen/time_sheet_screen.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import '../../../custom_widgets/Container_btn_with_gradient.dart';
import '../../../custom_widgets/appbar.dart';
import '../../../utils/helper.dart';
import '../../../utils/local_storage.dart';
import '../../menu_screen.dart';

var carMake, carMakeModel;
var setDefaultMake = true, setDefaultMakeModel = true;

class SelectClientScreen extends StatefulWidget {
  const SelectClientScreen({Key? key}) : super(key: key);

  @override
  _SelectClientScreenState createState() => _SelectClientScreenState();
}

class _SelectClientScreenState extends State<SelectClientScreen> {
  List<String> clientNames = [];
  String? dropdownValue;

  //--------------------------------------------------------------------------------------------------------------------------

  // void onTextFieldTap() {
  //   final List<SelectedListItem> _listOfCities = [
  //     for (var item in clientNames) SelectedListItem(name: item),
  //   ];
  //
  //   DropDownState(
  //     DropDown(
  //       bottomSheetTitle: const Text(
  //         "Select",
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20.0,
  //         ),
  //       ),
  //       submitButtonChild: const Text(
  //         'Done',
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       data: _listOfCities,
  //       // selectedItems: (List<dynamic> selectedList) {
  //       //   for (var item in selectedList) {
  //       //     Helper.showSnackBar(context: context, msg: item);
  //       //   }
  //       // },
  //
  //       selectedItems: (List<dynamic> selectedList) {
  //         // List<String> list = [];
  //         for (var item in selectedList) {
  //           if (item is SelectedListItem) {
  //             // list.add(item.name);
  //             Helper.dropdownNameListForSelectClientScreen.add(item.name);
  //             // dropdownValue = item.name;
  //           }
  //         }
  //         Helper.showSnackBar(
  //             context: context,
  //             msg: Helper.dropdownNameListForSelectClientScreen.toString());
  //       },
  //
  //       enableMultipleSelection: true,
  //     ),
  //   ).showModal(context);
  // }

  //--------------------------------------------------------------------------------------------------------------------------

  final List<Widget> _cardList = [];

  void _addCardWidget() {
    setState(() {
      _cardList.add(_card());
    });
  }

  Widget _card() {
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 12.w),
    //   child: DropdownButtonHideUnderline(
    //     child: Container(
    //       height: 60.h,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(13.r),
    //         color: const Color(0xff6fc4db).withOpacity(0.3),
    //       ),
    //       child: DropdownButtonFormField<String>(
    //         // validator: (value) {
    //         //   if (value == null || value == '') {
    //         //     return LocaleKeys.pleaseSelectClientValidationMsg
    //         //         .tr();
    //         //   }
    //         //   return null;
    //         // },
    //         decoration: const InputDecoration(
    //           enabledBorder: UnderlineInputBorder(
    //             borderSide: BorderSide(color: Colors.transparent),
    //           ),
    //           focusedBorder: UnderlineInputBorder(
    //             borderSide: BorderSide(color: Colors.transparent),
    //           ),
    //           isDense: true,
    //         ),
    //         isExpanded: true,
    //         value: dropdownValue,
    //         isDense: true,
    //         icon: Padding(
    //           padding: EdgeInsets.only(
    //             right: 4.w,
    //             top: 8.h,
    //           ),
    //           child: const Icon(
    //             Icons.keyboard_arrow_down_outlined,
    //             color: Colors.black54,
    //           ),
    //         ),
    //         hint: Padding(
    //           padding: EdgeInsets.only(
    //             left: 23.w,
    //             top: 8.h,
    //           ),
    //           child: Text(
    //             LocaleKeys.selectClient.tr(),
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontSize: 18.h,
    //             ),
    //           ),
    //         ),
    //         onChanged: (salutation) {
    //           setState(() {
    //             Helper.dropdownNameListForSelectClientScreen.add(salutation!);
    //           });
    //         },
    //         items: clientNames.map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Padding(
    //               padding: EdgeInsets.only(
    //                 left: 16.w,
    //                 top: 8.h,
    //               ),
    //               child: Text(
    //                 value,
    //                 style: TextStyle(
    //                   color: Colors.black54,
    //                   fontSize: 16.h,
    //                 ),
    //               ),
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff6fc4db), // red as border color
          ),
          color: const Color(0xff6fc4db).withOpacity(0.2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        width: 395.w,

        // padding: const EdgeInsets.all(0.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0.w),
              // helperText: 'ss',
              // errorStyle: TextStyle(fontSize: 4),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              // isDense: true,
            ),
            // validator: (value) {
            //   if (value?.isEmpty ?? true) {
            //     return LocaleKeys.pleaseSelectClientValidationMsg.tr();
            //   }
            //   return null;
            // },
            icon: Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xff6fc4db),
              ),
            ),
            isExpanded: true,
            value: dropdownValue,
            style: const TextStyle(
                // fontWeight: FontWeight.w500,
                color: Color(0xff6fc4db)),
            items: clientNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: clientNames.isNotEmpty ? value : null,
                child: Padding(
                  padding: EdgeInsets.only(left: 27.w),
                  child: Text(
                    value,
                    style: TextStyle(
                        color: const Color(0xff6fc4db), fontSize: 17.sp),
                  ),
                ),
              );
            }).toList(),
            hint: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                LocaleKeys.selectClient.tr(),
                style:
                    TextStyle(color: const Color(0xff6fc4db), fontSize: 17.sp),
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                Helper.dropdownNameListForSelectClientScreen.add(value!);
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // add client -----------------------------
    FirebaseFirestore.instance
        .collection('addClient')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (kDebugMode) {
          setState(() {
            clientNames.add(doc["clientName"]);
            if (kDebugMode) {
              print(doc["clientName"]);
            }
          });
        }
      }
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _cardList.clear();
  //   super.dispose();
  // }
  // --------------------------------------------------------------------------------- //

  // --------------------------------------------------------------------------------- //

  final _formKey = GlobalKey<FormState>();
  bool isEmpty = false;

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
          appBar: CustomAppBar(
            fun: () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const MenuScreen(),
              ),
            ),
            elevation: 0,
            title: LocaleKeys.selectClient.tr(),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.7),
                child: TextButton(
                  onPressed: _addCardWidget,
                  child: Text(
                    LocaleKeys.AddClient.tr(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),

              //New/// Dropdown
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('addClient')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    carMake = snapshot.data?.docs[0].get('clientName');
                    debugPrint('setDefault make: $carMake');
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff6fc4db), // red as border color
                      ),
                      color: const Color(0xff6fc4db).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    width: 400.w,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0.w),
                          // helperText: 'ss',
                          // errorStyle: TextStyle(fontSize: 4),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),

                          // isDense: true,
                        ),
                        isExpanded: false,
                        value: carMake,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 18.w),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xff6fc4db),
                          ),
                        ),
                        items: snapshot.data?.docs.map((value) {
                          return DropdownMenuItem(
                            value: value.get('clientName'),
                            child: Text(
                              '${value.get('clientName')}',
                              style: TextStyle(
                                  color: const Color(0xff6fc4db),
                                  fontSize: 17.sp),
                            ),
                          );
                        }).toList(),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            LocaleKeys.selectClient.tr(),
                            style: TextStyle(
                                color: const Color(0xff6fc4db),
                                fontSize: 17.sp),
                          ),
                        ),
                        onChanged: (value) {
                          debugPrint('selected onchange: $value');
                          setState(
                            () {
                              debugPrint('make selected: $value');
                              // Selected value will be stored
                              carMake = value;
                              // Default dropdown value won't be displayed anymore
                              setDefaultMake = false;
                              // Set makeModel to true to display first car from list
                              setDefaultMakeModel = true;
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              /// Dropdown
              /*         Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff6fc4db), // red as border color
                    ),
                    color: const Color(0xff6fc4db).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  width: 400.w,

                  // padding: const EdgeInsets.all(0.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20.0.w),
                        // helperText: 'ss',
                        // errorStyle: TextStyle(fontSize: 4),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),

                        // isDense: true,
                      ),
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return LocaleKeys.pleaseSelectClientValidationMsg
                      //         .tr();
                      //   }
                      //   return null;
                      // },
                      icon: Padding(
                        padding: EdgeInsets.only(right: 18.w),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xff6fc4db),
                        ),
                      ),
                      isExpanded: true,
                      value: dropdownValue,
                      style: const TextStyle(
                          // fontWeight: FontWeight.w500,
                          color: Color(0xff6fc4db)),
                      items: clientNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: clientNames.isNotEmpty ? value : null,
                          child: Padding(
                            padding: EdgeInsets.only(left: 27.w),
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: const Color(0xff6fc4db),
                                  fontSize: 17.sp),
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          LocaleKeys.selectClient.tr(),
                          style: TextStyle(
                              color: const Color(0xff6fc4db), fontSize: 17.sp),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(
                          () {
                            Helper.dropdownNameListForSelectClientScreen
                                .add(value!);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),*/
              Helper.customSizedBox,

              /// list for Clients
              SizedBox(
                height: _cardList.isNotEmpty ? height * 0.5 : 0,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(
                      androidOverscrollIndicator:
                          AndroidOverscrollIndicator.glow),
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: _cardList.length,
                      itemBuilder: (context, index) {
                        return (_cardList[index]);
                      }),
                ),
              ),

              // GestureDetector(
              //   onTap: () => onTextFieldTap(),
              //   child: Container(
              //     width: 380.w,
              //     height: 75.h,
              //     decoration: BoxDecoration(
              //       color: const Color(0xff6FC4DB).withOpacity(0.24),
              //       borderRadius: BorderRadius.circular(13.r),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 22.w),
              //       child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               LocaleKeys.selectClient.tr(),
              //               style: TextStyle(
              //                 color: Colors.grey.shade600,
              //               ),
              //             ),
              //             Image.asset(
              //               'assets/png_images/arrow-down_dropdown.png',
              //               isAntiAlias: true,
              //               // fit: BoxFit.cover,
              //               height: 25.h,
              //             ),
              //           ]),
              //     ),
              //   ),
              // )

              // SizedBox(
              //   height: height * 0.1,
              //   child: ScrollConfiguration(
              //     behavior: const ScrollBehavior(
              //         androidOverscrollIndicator:
              //             AndroidOverscrollIndicator.glow),
              //     child: ListView.separated(
              //         separatorBuilder: (context, index) =>
              //             SizedBox(height: 20.h),
              //         itemCount:
              //             Helper.dropdownNameListForSelectClientScreen.length,
              //         itemBuilder: (context, index) {
              //           return Text(Helper
              //               .dropdownNameListForSelectClientScreen[index]);
              //         }),
              //   ),
              // ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomContainerButton(
                        text: LocaleKeys.next_btn_text.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const TimeSheetScreen(),
                              ),
                            );
                          }
                        },
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
}
