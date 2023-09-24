import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import 'package:ole_app/utils/constant.dart';
import '../custom_widgets/appbar.dart';
import '../utils/helper.dart';
import 'edit_workDescription.dart';

class JustShowTableOFWorkDescriptionScreen extends StatefulWidget {
  const JustShowTableOFWorkDescriptionScreen({Key? key}) : super(key: key);

  @override
  _JustShowTableOFWorkDescriptionScreenState createState() =>
      _JustShowTableOFWorkDescriptionScreenState();
}

class _JustShowTableOFWorkDescriptionScreenState
    extends State<JustShowTableOFWorkDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helper.onWillPopFunc(
        context: context,
        className: const EditWorkDescription(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
            title: LocaleKeys.work_description_txt.tr(),
            fun: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const EditWorkDescription(),
                )),
            elevation: 0),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
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
                            padding: const EdgeInsets.symmetric(vertical: 60.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.2,
                                      blurRadius: 2,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              width: 368.w,
                              height: 700.h,
                              child: StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection('addWorkDescription')
                                      .orderBy('createdAt')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error = ${snapshot.error}');
                                    }

                                    if (snapshot.hasData) {
                                      final docs = snapshot.data!.docs;
                                      return ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black.withOpacity(0.1),
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
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      // "510-581",
                                                      data['cost-code'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 60.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.5),
                        //             spreadRadius: 5,
                        //             blurRadius: 7,
                        //             offset: const Offset(
                        //                 0, 3), // changes position of shadow
                        //           ),
                        //         ],
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(10.r)),
                        //     width: 368.w,
                        //     height: 700.h,
                        //     child: ListView.separated(
                        //       separatorBuilder: (context, index) => Divider(
                        //         color: Colors.black.withOpacity(0.1),
                        //         thickness: 2,
                        //       ),
                        //       itemCount: 30,
                        //       itemBuilder: (context, index) {
                        //         return Column(
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.all(12.r),
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text(
                        //                     "Full Day Work",
                        //                     style: TextStyle(
                        //                         color: Colors.black,
                        //                         fontSize: 15.sp,
                        //                         fontWeight: FontWeight.w600),
                        //                   ),
                        //                   Text(
                        //                     "510-581",
                        //                     style: TextStyle(
                        //                         color: Colors.black,
                        //                         fontSize: 15.sp,
                        //                         fontWeight: FontWeight.w600),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
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
}
