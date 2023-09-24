import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ole_app/screens/invoice_screen.dart';
import '../custom_widgets/menu_container_widget.dart';
import '../translations/locale_keys.g.dart';
import '../utils/helper.dart';
import 'NewFinalScreen/SelectProfessionView/select_profession_view.dart';
import 'edit_workDescription.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //===================================Start
  // DateTime? currentBackPressTime;
  // Future<bool> onWillPop(BuildContext context) {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
  //     currentBackPressTime = now;
  //     Navigator.pushReplacement(
  //       context,
  //       CupertinoPageRoute(
  //         builder: (context) => const MenuScreen(),
  //       ),
  //     );
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
//===================================END

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('addClient');

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: LocaleKeys.pressBackAgainToClose_txt.tr(),
      child: Scaffold(
        body: StreamBuilder(
            stream: _products.snapshots(), //build connection
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              ListView.builder(
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  Helper.selectedClients.addAll(documentSnapshot['clientName']);
                  log(documentSnapshot['clientName']);
                  return const Text('');
                },
              );

              return Container(
                height: 1.sh,
                width: 1.sw,
                child: SingleChildScrollView(
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 98.h),
                      SvgPicture.asset(
                        'assets/svg_images/langaugeSelectionPicSvg.svg',
                        fit: BoxFit.contain,
                        // height: 183.h,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      Text(
                        LocaleKeys.ole_text.tr(),
                        style: TextStyle(
                            fontSize: 29.84.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        LocaleKeys.invoicing_word.tr(),
                        style: TextStyle(
                            fontSize: 29.84.sp, fontWeight: FontWeight.w600),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      Column(
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MenuContainerWidget(
                                    textNumber: '1',
                                    imageUrl: 'assets/svg_images/note.svg',
                                    text: LocaleKeys.frst_menu_option.tr(),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const SelectProfessionScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  MenuContainerWidget(
                                    textNumber: '2',
                                    imageUrl: 'assets/svg_images/save-2.svg',
                                    text: LocaleKeys.scnd_menu_option.tr(),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                InvoicesScreen(LocaleKeys
                                                    .previous_invoice_txt
                                                    .tr()),
                                          ));
                                    },
                                  ),
                                ]),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MenuContainerWidget(
                                    textNumber: '3',
                                    imageUrl:
                                        'assets/svg_images/edit_client.svg',
                                    text: LocaleKeys.third_menu_option.tr(),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                InvoicesScreen(LocaleKeys
                                                    .clients_txt
                                                    .tr()),
                                          ));
                                    },
                                  ),
                                  MenuContainerWidget(
                                    textNumber: '4',
                                    imageUrl:
                                        'assets/svg_images/edit_worker.svg',
                                    text: LocaleKeys.frth_menu_option.tr(),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                InvoicesScreen(LocaleKeys
                                                    .workers_txt
                                                    .tr()),
                                          ));
                                    },
                                  ),
                                ]),
                          ]),
                      SizedBox(
                        height: 25.h,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const EditWorkDescription(),
                              ));
                        },
                        child: Text(
                          LocaleKeys.edit_work_descriptions.tr(),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: const Color(0xff61ACBE),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.68.sp),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
