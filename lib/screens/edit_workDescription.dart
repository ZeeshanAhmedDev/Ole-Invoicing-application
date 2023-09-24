import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import 'package:ole_app/utils/constant.dart';
import '../custom_widgets/Container_btn_with_gradient.dart';
import '../custom_widgets/appbar.dart';
import '../models/AddWorkDescriptionModel.dart';
import '../utils/helper.dart';
import '../utils/string_resource.dart';
import 'addworkDescription.dart';
import 'justShowTableOFWorkDescriptionScreen.dart';
import 'menu_screen.dart';

class EditWorkDescription extends StatefulWidget {
  const EditWorkDescription({Key? key}) : super(key: key);

  @override
  _EditWorkDescriptionState createState() => _EditWorkDescriptionState();
}

class _EditWorkDescriptionState extends State<EditWorkDescription> {
  // AddWorkDescriptionModel? _addWorkDescriptionModel;
  @override
  Widget build(BuildContext context) {
    //==============================================
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    //==============================================
    return WillPopScope(
      onWillPop: () => Helper.onWillPopFunc(
        context: context,
        className: const MenuScreen(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.work_description_txt.tr(),
          fun: () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const MenuScreen(),
              )),
          elevation: 0,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff66CBE3),
                                    Color(0xff6FC4DB),
                                  ]),
                                  borderRadius: BorderRadius.circular(10.r)),
                              width: 368.w,
                              height: 80.h,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.description_txt.tr(),
                                      style: TextStyle(
                                          color: Constants.kWhiteColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      LocaleKeys.costCode_txt.tr(),
                                      style: TextStyle(
                                          color: Constants.kWhiteColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 60.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                width: 368.w,
                                height: 470.h,
                                child: StreamBuilder<
                                        QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection('addWorkDescription')
                                        .orderBy('createdAt')
                                        .limit(8)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Error = ${snapshot.error}');
                                      }

                                      if (snapshot.hasData) {
                                        final docs = snapshot.data!.docs;
                                        return ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            thickness: 2,
                                          ),
                                          itemCount: docs.length,
                                          itemBuilder: (_, i) {
                                            final data = docs[i].data();
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(12.r),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        // "Full Day Work",
                                                        data['workDescription'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        // "510-581",
                                                        data['cost-code'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Color(Constants.lightgreen),
                                      ));
                                    }),
                              )
                              // Positioned(child: child),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomContainerButton(
                      text: LocaleKeys.view_all_txt.tr(),
                      onPressed: () {
                        // deletePosts(FirebaseFirestore.instance
                        //     .collection('addWorkDescription'));
                        // Helper.showRemainingData == true?
                        //Dart
                        //Dart

                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const JustShowTableOFWorkDescriptionScreen(),
                            ));
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomContainerButton(
                      text: LocaleKeys.add_work_description_txt.tr(),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddWorkDescriptionScreen(
                                  LocaleKeys.add_work_description_txt.tr()),
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
    );
  }

  Stream<List<AddWorkDescriptionModel>> readWorkDescription() =>
      FirebaseFirestore.instance
          .collection('addWorkDescription')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AddWorkDescriptionModel.fromJson(doc.data()))
              .toList());

  // Widget buildUsers(AddWorkDescriptionModel user) => Padding(
  //       padding: EdgeInsets.all(12.r),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             // "Full Day Work",
  //             user.workDescription.toString(),
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 15.sp,
  //                 fontWeight: FontWeight.w600),
  //           ),
  //           Text(
  //             user.costCode.toString(),
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 15.sp,
  //                 fontWeight: FontWeight.w600),
  //           ),
  //         ],
  //       ),
  //     );

  // void deletePosts(CollectionReference collection) {
  //   var doc = collection.get();
  //   doc.then((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       doc.reference.delete();
  //     });
  //   });
  // }

  Widget buildUsers(AddWorkDescriptionModel user) => ListTile(
        title: Text(user.workDescription),
      );
}
