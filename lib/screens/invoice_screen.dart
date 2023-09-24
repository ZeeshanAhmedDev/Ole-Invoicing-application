import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ndialog/ndialog.dart';
import 'package:ole_app/screens/NewFinalScreen/InvoiceScreens/create_invoice_screen.dart';
import 'package:ole_app/screens/edit_worker_Screen.dart';
import 'package:ole_app/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import '../Provider.dart';
import '../addClientScreen.dart';
import '../custom_widgets/appbar.dart';
import '../utils/constant.dart';
import '../utils/helper.dart';
import 'NewFinalScreen/SelectCategories/selectCategoriesModel.dart';
import 'menu_screen.dart';

class InvoicesScreen extends StatefulWidget {
  var appBarName;
  InvoicesScreen(
    this.appBarName, {
    Key? key,
  }) : super(key: key);

  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  /// ======================== DialogBox Proper ================================= Start

  List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel =
      [];
  _showDialog(int index, BuildContext context) async {
    final date = Provider.of<DataProviders>(context, listen: false);
    await DialogBackground(
      blur: 0.5,
      dialog: AlertDialog(
        // title: const Text("Alert Dialog"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.h),
        ),
        content: widget.appBarName == LocaleKeys.previous_invoice_txt.tr()
            ? StreamBuilder(
                stream: previousInvoice.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  final QueryDocumentSnapshot<Object?>? documentSnapshot =
                      streamSnapshot.data?.docs[index];
                  // Helper.selectCustomers.add(documentSnapshot['clientName']);

                  if (!streamSnapshot.hasData) {
                    return CircularProgressIndicator(
                      color: Color(Constants.lightgreen),
                    );
                  } else if (streamSnapshot.hasError) {
                    return Center(
                        child: Text('Error = ${streamSnapshot.error}'));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              documentSnapshot!['clientName']
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              style: TextStyle(
                                fontSize: 24.42.sp,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                'assets/svg_images/cross_cut.svg',
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Total: \$125.00',
                          style: TextStyle(
                            fontSize: 14.42.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${LocaleKeys.date_txt.tr()}: ${DateFormat.yMd().format(documentSnapshot['createdAt'].toDate())}',
                          style: TextStyle(
                            fontSize: 14.42.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${LocaleKeys.invoice_number_txt.tr()}. : ${documentSnapshot['invoiceNo']}',
                          style: TextStyle(
                            fontSize: 14.42.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.black,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => widget.appBarName ==
                                      LocaleKeys.previous_invoice_txt.tr()
                                  ? Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => CreateInvoiceScreenNew(
                                            checkBoxSettingsForCategoriesModel
                                            // weekEndingDate:
                                            //     DateFormat('dd-MM-yyyy').format(
                                            //   documentSnapshot['createdAt']
                                            //       .toDate(),
                                            // ),
                                            ),
                                      ),
                                    )
                                  : const SizedBox(),
                              child: Container(
                                alignment: Alignment.center,
                                width: 280.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.r),
                                  color: const Color(0xff979797),
                                ),
                                child: Text(
                                  LocaleKeys.resuse_txt.tr(),
                                  style: TextStyle(
                                    fontSize: 16.61.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.appBarName ==
                                        LocaleKeys.previous_invoice_txt.tr()
                                    ? Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => CreateInvoiceScreenNew(
                                              checkBoxSettingsForCategoriesModel
                                              // weekEndingDate:
                                              //     DateFormat('dd-MM-yyyy').format(
                                              //   documentSnapshot['createdAt']
                                              //       .toDate(),
                                              // ),
                                              ),
                                        ),
                                      )
                                    : const SizedBox();

                                // Helper.selectCustomers
                                //     .add(documentSnapshot['clientName']);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 280.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.r),
                                  color: const Color(0xff47AD45),
                                ),
                                child: Text(
                                  LocaleKeys.edit_txt.tr(),
                                  style: TextStyle(
                                    fontSize: 16.61.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                _deletePreviousInvoices(documentSnapshot.id)
                                    .then((value) => Navigator.pop(context));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 280.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.r),
                                  color: const Color(0xffAD4545),
                                ),
                                child: Text(
                                  LocaleKeys.delete_txt.tr(),
                                  style: TextStyle(
                                    fontSize: 16.61.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }
                })

            ///
            : widget.appBarName == LocaleKeys.clients_txt.tr()
                ? StreamBuilder(
                    stream: clientss.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      final QueryDocumentSnapshot<Object?>? documentSnapshot =
                          streamSnapshot.data?.docs[index];

                      if (!streamSnapshot.hasData) {
                        return CircularProgressIndicator(
                          color: Color(Constants.lightgreen),
                        );
                      } else if (streamSnapshot.hasError) {
                        return Center(
                            child: Text('Error = ${streamSnapshot.error}'));
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  documentSnapshot!['clientName']
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', ''),
                                  style: TextStyle(
                                    fontSize: 24.42.sp,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: SvgPicture.asset(
                                    'assets/svg_images/cross_cut.svg',
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '${documentSnapshot['clientAddress']}',
                              style: TextStyle(
                                fontSize: 14.42.sp,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //   alignment: Alignment.center,
                                //   width: 280.w,
                                //   height: 44.h,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(22.r),
                                //     color: Color(0xff979797),
                                //   ),
                                //   child: Text(
                                //     // "Reuse",
                                //     LocaleKeys.resuse_txt.tr(),
                                //     style: TextStyle(
                                //       fontSize: 16.61.sp,
                                //       fontWeight: FontWeight.w400,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _update(documentSnapshot);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 280.w,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: const Color(0xff47AD45),
                                    ),
                                    child: Text(
                                      // "Edit",
                                      LocaleKeys.edit_txt.tr(),
                                      style: TextStyle(
                                        fontSize: 16.61.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _delete(documentSnapshot.id).then(
                                        (value) => Navigator.pop(context));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 280.w,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: const Color(0xffAD4545),
                                    ),
                                    child: Text(
                                      LocaleKeys.delete_txt.tr(),
                                      style: TextStyle(
                                        fontSize: 16.61.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      }
                    })
                : StreamBuilder(
                    stream: workerInvoice.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      final QueryDocumentSnapshot<Object?>? documentSnapshot =
                          streamSnapshot.data?.docs[index];

                      if (!streamSnapshot.hasData) {
                        return CircularProgressIndicator(
                          color: Color(Constants.lightgreen),
                        );
                      } else if (streamSnapshot.hasError) {
                        return Center(
                            child: Text('Error = ${streamSnapshot.error}'));
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  documentSnapshot!['workerClientName']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 24.42.sp,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: SvgPicture.asset(
                                    'assets/svg_images/cross_cut.svg',
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '${documentSnapshot['workerClientAddress']}',
                              style: TextStyle(
                                fontSize: 14.42.sp,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _updateWorker(documentSnapshot);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 280.w,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: const Color(0xff47AD45),
                                    ),
                                    child: Text(
                                      // "Edit",
                                      LocaleKeys.edit_txt.tr(),
                                      style: TextStyle(
                                        fontSize: 16.61.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _deleteWorker(documentSnapshot.id).then(
                                        (value) => Navigator.pop(context));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 280.w,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: const Color(0xffAD4545),
                                    ),
                                    child: Text(
                                      LocaleKeys.delete_txt.tr(),
                                      style: TextStyle(
                                        fontSize: 16.61.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      }
                    }),
      ),
    ).show(context);
  }

  /// ======================== DialogBox Proper ================================= End
  var getdocumentSnapshot;

  /// ======================== Controllers ================================= End

  // ---------------------------------------------------- Client Controllers
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNoController = TextEditingController();

  // ---------------------------------------------------- Worker Controllers
  final _nameWorkerController = TextEditingController();
  final _addressWorkerController = TextEditingController();
  final _phoneNoWorkerController = TextEditingController();

  // ---------------------------------------------------- previous Invoices Controllers
  // final _nameController = TextEditingController();
  // final _addressController = TextEditingController();
  // final _phoneNoController = TextEditingController();

  /// ======================== Controllers ================================= End

  final CollectionReference clientss =
      FirebaseFirestore.instance.collection('addClient');

  final CollectionReference previousInvoice =
      FirebaseFirestore.instance.collection('previousInvoice');

  final CollectionReference workerInvoice =
      FirebaseFirestore.instance.collection('editWorker');

  // showAlertCustomerDialogForCancelOrResolved(BuildContext context, int index) {
  //   showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(
  //               MediaQuery.of(context).size.height * 0.02,
  //             ),
  //           ),
  //           child: SizedBox(
  //               height: 327.h,
  //               // width: double.infinity,
  //               width: 323.w,
  //               child: Padding(
  //                 padding: EdgeInsets.all(20.h),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   // mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // widget.appBarName != 'Clients' &&
  //                     widget.appBarName == "Previous Invoices"
  //                         ? StreamBuilder(
  //                             stream: previousInvoice.snapshots(),
  //                             builder: (context,
  //                                 AsyncSnapshot<QuerySnapshot> streamSnapshot) {
  //                               final DocumentSnapshot documentSnapshot =
  //                                   streamSnapshot.data!.docs[index];
  //
  //                               if (!streamSnapshot.hasData) {
  //                                 return Center(
  //                                     child: CircularProgressIndicator(
  //                                   color: Color(Constants.lightgreen),
  //                                 ));
  //                               } else if (streamSnapshot.hasError) {
  //                                 return Text(
  //                                     'Error = ${streamSnapshot.error}');
  //                               } else {
  //                                 return Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   // mainAxisSize: MainAxisSize.min,
  //                                   children: [
  //                                     Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           documentSnapshot['clientName']
  //                                               .toString()
  //                                               .replaceAll('[', '')
  //                                               .replaceAll(']', ''),
  //                                           style: TextStyle(
  //                                             fontSize: 24.42.sp,
  //                                             fontWeight: FontWeight.w700,
  //                                             color: CupertinoColors.black,
  //                                           ),
  //                                         ),
  //                                         Padding(
  //                                           padding:
  //                                               EdgeInsets.only(left: 160.0.w),
  //                                           child: InkWell(
  //                                             onTap: () =>
  //                                                 Navigator.pop(context),
  //                                             child: SvgPicture.asset(
  //                                               'assets/svg_images/cross_cut.svg',
  //                                             ),
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                     SizedBox(
  //                                       height: 8.h,
  //                                     ),
  //                                     Text(
  //                                       // 'Total : \$125.00',
  //                                       'Total: \$125.00',
  //                                       style: TextStyle(
  //                                         fontSize: 14.42.sp,
  //                                         fontWeight: FontWeight.w500,
  //                                         color: CupertinoColors.black,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 4.h,
  //                                     ),
  //                                     Text(
  //                                       '${LocaleKeys.date_txt.tr()}: ${DateFormat.yMd().format(documentSnapshot['createdAt'].toDate())}',
  //                                       style: TextStyle(
  //                                         fontSize: 14.42.sp,
  //                                         fontWeight: FontWeight.w500,
  //                                         color: CupertinoColors.black,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 4.h,
  //                                     ),
  //                                     Text(
  //                                       '${LocaleKeys.invoice_number_txt.tr()}. : ${documentSnapshot['invoiceNo']}',
  //                                       style: TextStyle(
  //                                         fontSize: 14.42.sp,
  //                                         fontWeight: FontWeight.w500,
  //                                         color: CupertinoColors.black,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 18.h,
  //                                     ),
  //                                     Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.center,
  //                                       children: [
  //                                         Container(
  //                                           alignment: Alignment.center,
  //                                           width: 280.w,
  //                                           height: 44.h,
  //                                           decoration: BoxDecoration(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(22.r),
  //                                             color: Color(0xff979797),
  //                                           ),
  //                                           child: Text(
  //                                             // "Reuse",
  //                                             LocaleKeys.resuse_txt.tr(),
  //                                             style: TextStyle(
  //                                               fontSize: 16.61.sp,
  //                                               fontWeight: FontWeight.w400,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10.h,
  //                                         ),
  //                                         GestureDetector(
  //                                           onTap: () => widget.appBarName ==
  //                                                   "Clients"
  //                                               ? Navigator.pushReplacement(
  //                                                   context,
  //                                                   CupertinoPageRoute(
  //                                                     builder: (context) =>
  //                                                         EditClientScreen(
  //                                                       "Edit Client",
  //                                                       clientName:
  //                                                           // Helper.data['clientName'],
  //                                                           Helper.data[
  //                                                               'clientName'],
  //                                                       clientAddress: Helper
  //                                                           .data['clientName'],
  //                                                       phoneNo: Helper
  //                                                           .data['phoneNo'],
  //                                                     ),
  //                                                   ))
  //                                               : widget.appBarName == "Workers"
  //                                                   ? Navigator.pushReplacement(
  //                                                       context,
  //                                                       CupertinoPageRoute(
  //                                                           builder: (context) =>
  //                                                               EditWorkerScreen(
  //                                                                   'Edit Worker')))
  //                                                   : widget.appBarName ==
  //                                                           "Previous Invoices"
  //                                                       ? Navigator.pushReplacement(
  //                                                           context,
  //                                                           CupertinoPageRoute(
  //                                                               builder: (context) =>
  //                                                                   CreateInvoiceScreen(
  //                                                                       'Create Invoice')))
  //                                                       : log("ff"),
  //                                           child: Container(
  //                                             alignment: Alignment.center,
  //                                             width: 280.w,
  //                                             height: 44.h,
  //                                             decoration: BoxDecoration(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(22.r),
  //                                               color: const Color(0xff47AD45),
  //                                             ),
  //                                             child: Text(
  //                                               // "Edit",
  //                                               LocaleKeys.edit_txt.tr(),
  //                                               style: TextStyle(
  //                                                 fontSize: 16.61.sp,
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10.h,
  //                                         ),
  //                                         GestureDetector(
  //                                           onTap: () {
  //                                             _deletePreviousInvoices(
  //                                                     documentSnapshot.id)
  //                                                 .then((value) =>
  //                                                     Navigator.pop(context));
  //                                           },
  //                                           child: Container(
  //                                             alignment: Alignment.center,
  //                                             width: 280.w,
  //                                             height: 44.h,
  //                                             decoration: BoxDecoration(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(22.r),
  //                                               color: const Color(0xffAD4545),
  //                                             ),
  //                                             child: Text(
  //                                               LocaleKeys.delete_txt.tr(),
  //                                               style: TextStyle(
  //                                                 fontSize: 16.61.sp,
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         )
  //                                       ],
  //                                     )
  //                                   ],
  //                                 );
  //                               }
  //                             })
  //
  //                         ///
  //
  //                         : StreamBuilder(
  //                             stream: clientss.snapshots(),
  //                             builder: (context,
  //                                 AsyncSnapshot<QuerySnapshot> streamSnapshot) {
  //                               if (streamSnapshot.hasError) {
  //                                 return Text(
  //                                     'Error = ${streamSnapshot.error}');
  //                               } else if (streamSnapshot.hasData) {
  //                                 return Expanded(
  //                                   child: ListView.builder(
  //                                     physics: const BouncingScrollPhysics(),
  //                                     shrinkWrap: true,
  //                                     itemCount:
  //                                         streamSnapshot.data!.docs.length,
  //                                     itemBuilder: (context, index) {
  //                                       final DocumentSnapshot
  //                                           documentSnapshot =
  //                                           streamSnapshot.data!.docs[index];
  //
  //                                       return Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.start,
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         // mainAxisSize: MainAxisSize.min,
  //                                         children: [
  //                                           Row(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment
  //                                                     .spaceBetween,
  //                                             children: [
  //                                               Text(
  //                                                 // 'Painted Rooms',
  //                                                 LocaleKeys.painted_rooms_txt
  //                                                     .tr(),
  //                                                 style: TextStyle(
  //                                                   fontSize: 24.42.sp,
  //                                                   fontWeight: FontWeight.w700,
  //                                                   color:
  //                                                       CupertinoColors.black,
  //                                                 ),
  //                                               ),
  //                                               Padding(
  //                                                 padding: EdgeInsets.only(
  //                                                     left: 80.0.w),
  //                                                 child: InkWell(
  //                                                   onTap: () =>
  //                                                       Navigator.pop(context),
  //                                                   child: SvgPicture.asset(
  //                                                     'assets/svg_images/cross_cut.svg',
  //                                                   ),
  //                                                 ),
  //                                               )
  //                                             ],
  //                                           ),
  //                                           SizedBox(
  //                                             height: 8.h,
  //                                           ),
  //                                           Text(
  //                                             documentSnapshot['clientName'],
  //                                             style: TextStyle(
  //                                               fontSize: 14.42.sp,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: CupertinoColors.black,
  //                                             ),
  //                                           ),
  //                                           SizedBox(
  //                                             height: 4.h,
  //                                           ),
  //                                           Text(
  //                                             '${LocaleKeys.date_txt.tr()}: ${Helper.convertDateTimeDisplay(DateTime.now().toString())}',
  //                                             style: TextStyle(
  //                                               fontSize: 14.42.sp,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: CupertinoColors.black,
  //                                             ),
  //                                           ),
  //                                           SizedBox(
  //                                             height: 4.h,
  //                                           ),
  //                                           Text(
  //                                             '${LocaleKeys.invoice_number_txt.tr()}. : ${Helper.convertDateTimeDisplay(DateTime.now().toString())}',
  //                                             style: TextStyle(
  //                                               fontSize: 14.42.sp,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: CupertinoColors.black,
  //                                             ),
  //                                           ),
  //                                           SizedBox(
  //                                             height: 18.h,
  //                                           ),
  //                                           Column(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.center,
  //                                             children: [
  //                                               Container(
  //                                                 alignment: Alignment.center,
  //                                                 width: 280.w,
  //                                                 height: 44.h,
  //                                                 decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           22.r),
  //                                                   color: Color(0xff979797),
  //                                                 ),
  //                                                 child: Text(
  //                                                   // "Reuse",
  //                                                   LocaleKeys.resuse_txt.tr(),
  //                                                   style: TextStyle(
  //                                                     fontSize: 16.61.sp,
  //                                                     fontWeight:
  //                                                         FontWeight.w400,
  //                                                     color: Colors.white,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 10.h,
  //                                               ),
  //                                               GestureDetector(
  //                                                 onTap: () => widget
  //                                                             .appBarName ==
  //                                                         "Clients"
  //                                                     ? Navigator
  //                                                         .pushReplacement(
  //                                                             context,
  //                                                             CupertinoPageRoute(
  //                                                               builder:
  //                                                                   (context) =>
  //                                                                       EditClientScreen(
  //                                                                 "Edit Client",
  //                                                                 clientName:
  //                                                                     // Helper.data['clientName'],
  //                                                                     Helper.data[
  //                                                                             index]
  //                                                                         [
  //                                                                         'clientName'],
  //                                                                 clientAddress:
  //                                                                     Helper.data[
  //                                                                         'clientAddress'],
  //                                                                 phoneNo: Helper
  //                                                                         .data[
  //                                                                     'phoneNo'],
  //                                                               ),
  //                                                             ))
  //                                                     : widget.appBarName ==
  //                                                             "Workers"
  //                                                         ? Navigator.pushReplacement(
  //                                                             context,
  //                                                             CupertinoPageRoute(
  //                                                                 builder: (context) =>
  //                                                                     EditWorkerScreen(
  //                                                                         'Edit Worker')))
  //                                                         : widget.appBarName ==
  //                                                                 "Previous Invoices"
  //                                                             ? Navigator.pushReplacement(
  //                                                                 context,
  //                                                                 CupertinoPageRoute(
  //                                                                     builder: (context) =>
  //                                                                         CreateInvoiceScreen(
  //                                                                             'Create Invoice')))
  //                                                             : log("ff"),
  //                                                 child: Container(
  //                                                   alignment: Alignment.center,
  //                                                   width: 280.w,
  //                                                   height: 44.h,
  //                                                   decoration: BoxDecoration(
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             22.r),
  //                                                     color: const Color(
  //                                                         0xff47AD45),
  //                                                   ),
  //                                                   child: Text(
  //                                                     // "Edit",
  //                                                     LocaleKeys.edit_txt.tr(),
  //                                                     style: TextStyle(
  //                                                       fontSize: 16.61.sp,
  //                                                       fontWeight:
  //                                                           FontWeight.w400,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(
  //                                                 height: 10.h,
  //                                               ),
  //                                               GestureDetector(
  //                                                 onTap: () {
  //                                                   // final user =
  //                                                   //     FirebaseFirestore
  //                                                   //         .instance
  //                                                   //         .collection(
  //                                                   //             'addClient')
  //                                                   //         .doc(Helper
  //                                                   //             .data['id']);
  //                                                   // user.delete();
  //                                                 },
  //                                                 child: Container(
  //                                                   alignment: Alignment.center,
  //                                                   width: 280.w,
  //                                                   height: 44.h,
  //                                                   decoration: BoxDecoration(
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             22.r),
  //                                                     color: const Color(
  //                                                         0xffAD4545),
  //                                                   ),
  //                                                   child: Text(
  //                                                     // "Delete",
  //                                                     LocaleKeys.delete_txt
  //                                                         .tr(),
  //                                                     style: TextStyle(
  //                                                       fontSize: 16.61.sp,
  //                                                       fontWeight:
  //                                                           FontWeight.w400,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               )
  //                                             ],
  //                                           )
  //                                         ],
  //                                       );
  //                                     },
  //                                   ),
  //                                 );
  //                               }
  //
  //                               return Center(
  //                                   child: CircularProgressIndicator(
  //                                 color: Color(Constants.lightgreen),
  //                               ));
  //                             }),
  //                   ],
  //                 ),
  //               )),
  //         );
  //       });
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helper.onWillPopFunc(
        context: context,
        className: const MenuScreen(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.appBarName ?? '',
          fun: () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const MenuScreen(),
              )),
          elevation: 0,
          leftText: widget.appBarName == LocaleKeys.clients_txt.tr()
              ? LocaleKeys.AddClient.tr()
              : widget.appBarName == LocaleKeys.workers_txt.tr()
                  ? LocaleKeys.AddWorker.tr()
                  : '',
          funOfLeftText: () {
            widget.appBarName == LocaleKeys.clients_txt.tr()
                ? Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          AddClient(appBarName: LocaleKeys.AddClient.tr()),
                    ))
                : widget.appBarName == LocaleKeys.workers_txt.tr()
                    ? Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              EditWorkerScreen(LocaleKeys.AddWorker.tr()),
                        ))
                    : Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              EditWorkerScreen(LocaleKeys.workers_txt.tr()),
                        ));
          },
        ),

        ///
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    //  Previous Invoices
                    height: 24.h,
                  ),
                  widget.appBarName == LocaleKeys.clients_txt.tr()
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            alignment: Alignment.center,
                            child: StreamBuilder(
                                stream: clientss.snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot>
                                        streamSnapshot) {
                                  if (streamSnapshot.hasError) {
                                    return Text(
                                        'Error = ${streamSnapshot.error}');
                                  } else if (!streamSnapshot.hasData) {
                                    return const CircularProgressIndicator(
                                      color: Color(0xff6FC4DB),
                                    );
                                  }

                                  if (streamSnapshot.hasData) {
                                    return SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.separated(
                                        itemCount:
                                            streamSnapshot.data!.docs.length,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                          color: Colors.transparent,
                                        ),
                                        itemBuilder: (context, index) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[index];
                                          return Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 368.w,
                                                    height: 86.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black26
                                                          .withOpacity(0.15),
                                                      border: Border.all(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.2)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13.r),
                                                    ),
                                                    // child:
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                left: 40.w,
                                                top: 17.h,
                                                child: Text(
                                                  documentSnapshot['clientName']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 17.h,
                                                left: 210.w,
                                                child: Text(
                                                  'Date: ${DateFormat.yMd().format(documentSnapshot['createdAt'].toDate())}',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 49.h,
                                                left: 40.w,
                                                child: Text(
                                                  documentSnapshot[
                                                          'clientAddress']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 49.h,
                                                left: 210.w,
                                                child: Text(
                                                  documentSnapshot['phoneNo']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 0.h,
                                                  left: 364.w,
                                                  child: GestureDetector(
                                                    onTap: () => _delete(
                                                        documentSnapshot.id),
                                                    child: Container(
                                                      width: 34.w,
                                                      height: 43.h,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffAD4545),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          13.r))),
                                                    ),
                                                  )),
                                              Positioned(
                                                top: 42.h,
                                                left: 364.w,
                                                child: GestureDetector(
                                                  onTap: () => _showDialog(
                                                      index, context),
                                                  child: Container(
                                                    width: 34.w,
                                                    height: 43.h,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff47AD45),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        13.r))),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 15.h,
                                                left: 372.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _delete(
                                                        documentSnapshot.id);
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/svg_images/trash.svg',
                                                    // fit: BoxFit.contain,
                                                    height: 18.h,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 57.h,
                                                left: 372.w,
                                                child: GestureDetector(
                                                  onTap: () => _showDialog(
                                                      index, context),
                                                  child: SvgPicture.asset(
                                                    'assets/svg_images/arrow_right_for_delete.svg',
                                                    // fit: BoxFit.contain,
                                                    height: 12.h,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }

                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Color(Constants.lightgreen),
                                  ));
                                }),
                          ),
                        )
                      : widget.appBarName == LocaleKeys.workers_txt.tr()
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                alignment: Alignment.center,
                                child: StreamBuilder(
                                    stream: workerInvoice.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasError) {
                                        return Text(
                                            'Error = ${streamSnapshot.error}');
                                      } else if (!streamSnapshot.hasData) {
                                        return const CircularProgressIndicator(
                                          color: Color(0xff6FC4DB),
                                        );
                                      }

                                      if (streamSnapshot.hasData) {
                                        return SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: ListView.separated(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              color: Colors.transparent,
                                            ),
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final DocumentSnapshot
                                                  documentSnapshot =
                                                  streamSnapshot
                                                      .data!.docs[index];
                                              return Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 368.w,
                                                        height: 86.h,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .black26
                                                                .withOpacity(
                                                                    0.15),
                                                            border: Border.all(
                                                                color: const Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.2)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r)),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    left: 40.w,
                                                    top: 17.h,
                                                    child: Text(
                                                      documentSnapshot[
                                                              'workerClientName']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 17.h,
                                                    left: 210.w,
                                                    child: Text(
                                                      'Date: ${DateFormat.yMd().format(documentSnapshot['createdAt'].toDate())}',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 49.h,
                                                    left: 40.w,
                                                    child: Text(
                                                      documentSnapshot[
                                                          'workerClientAddress'],
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 49.h,
                                                    left: 210.w,
                                                    child: Text(
                                                      documentSnapshot[
                                                          'phoneNo'],
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0.h,
                                                      left: 364.w,
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            _deleteWorker(
                                                                documentSnapshot
                                                                    .id),
                                                        child: Container(
                                                          width: 34.w,
                                                          height: 43.h,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffAD4545),
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          13.r))),
                                                        ),
                                                      )),
                                                  Positioned(
                                                    top: 42.h,
                                                    left: 364.w,
                                                    child: GestureDetector(
                                                      onTap: () => _showDialog(
                                                          index, context),
                                                      child: Container(
                                                        width: 34.w,
                                                        height: 43.h,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xff47AD45),
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            13.r))),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 15.h,
                                                    left: 372.w,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _deleteWorker(
                                                              documentSnapshot
                                                                  .id),
                                                      child: SvgPicture.asset(
                                                        'assets/svg_images/trash.svg',
                                                        // fit: BoxFit.contain,
                                                        height: 18.h,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 57.h,
                                                    left: 372.w,
                                                    child: GestureDetector(
                                                      onTap: () => _showDialog(
                                                          index, context),
                                                      child: SvgPicture.asset(
                                                        'assets/svg_images/arrow_right_for_delete.svg',
                                                        // fit: BoxFit.contain,
                                                        height: 12.h,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      }

                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Color(Constants.lightgreen),
                                      ));
                                    }),
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                alignment: Alignment.center,
                                // onTap: () => onTap,
                                child: StreamBuilder(
                                    stream: previousInvoice.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasError) {
                                        return Text(
                                            'Error = ${streamSnapshot.error}');
                                      } else if (!streamSnapshot.hasData) {
                                        return const CircularProgressIndicator(
                                          color: Color(0xff6FC4DB),
                                        );
                                      }

                                      if (streamSnapshot.hasData) {
                                        return SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: ListView.separated(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              color: Colors.transparent,
                                              // thickness: 4,
                                            ),
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final DocumentSnapshot
                                                  documentSnapshot =
                                                  streamSnapshot
                                                      .data!.docs[index];
                                              return Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 368.w,
                                                        height: 86.h,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .black26
                                                                .withOpacity(
                                                                    0.15),
                                                            border: Border.all(
                                                                color: const Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.2)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r)),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    left: 40.w,
                                                    top: 17.h,
                                                    child: Text(
                                                      documentSnapshot[
                                                              'clientName']
                                                          .toString()
                                                          .replaceAll('[', '')
                                                          .replaceAll(']', ''),
                                                      style: TextStyle(
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 17.h,
                                                    left: 210.w,
                                                    child: Text(
                                                      'Date: ${DateFormat.yMd().format(documentSnapshot['createdAt'].toDate())}',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  // Positioned(
                                                  //   top: 49.h,
                                                  //   left: 40.w,
                                                  //   child: Text(
                                                  //     'Al Orozco',
                                                  //     style: TextStyle(
                                                  //       fontSize: 17.sp,
                                                  //       fontWeight:
                                                  //           FontWeight.w600,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Positioned(
                                                    top: 49.h,
                                                    left: 210.w,
                                                    child: Text(
                                                      // '\$125.00',
                                                      "Inv. no: " +
                                                          documentSnapshot[
                                                              'invoiceNo'],
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0.h,
                                                      left: 364.w,
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            _deletePreviousInvoices(
                                                                documentSnapshot
                                                                    .id),
                                                        child: Container(
                                                          width: 34.w,
                                                          height: 43.h,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffAD4545),
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          13.r))),
                                                        ),
                                                      )),
                                                  Positioned(
                                                    top: 42.h,
                                                    left: 364.w,
                                                    child: GestureDetector(
                                                      onTap: () => _showDialog(
                                                          index, context),
                                                      child: Container(
                                                        width: 34.w,
                                                        height: 43.h,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xff47AD45),
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            13.r))),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 15.h,
                                                    left: 372.w,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _deletePreviousInvoices(
                                                              documentSnapshot
                                                                  .id),
                                                      child: SvgPicture.asset(
                                                        'assets/svg_images/trash.svg',
                                                        // fit: BoxFit.contain,
                                                        height: 18.h,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 57.h,
                                                    left: 372.w,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          // showAlertCustomerDialogForCancelOrResolved(
                                                          //     context, index),
                                                          _showDialog(
                                                              index, context),
                                                      child: SvgPicture.asset(
                                                        'assets/svg_images/arrow_right_for_delete.svg',
                                                        // fit: BoxFit.contain,
                                                        height: 12.h,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      }

                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Color(Constants.lightgreen),
                                      ));
                                    }),
                              ),
                            ),
                  SizedBox(
                    height: 140.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ============================================  For Clients =============================================== ///
  // =========== Delete Record For Clients =================== //
  Future<void> _delete(String id) async {
    await clientss.doc(id).delete();
    Helper.showToast(LocaleKeys.deletedSuccessfullyMsg_text.tr());
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['clientName'];
      _addressController.text = documentSnapshot['clientAddress'].toString();
      _phoneNoController.text = documentSnapshot['phoneNo'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.client_name_txt.tr(),
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.address_txt.tr(),
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _phoneNoController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phoneNumber_txt.tr(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(
                    LocaleKeys.update_txt.tr(),
                  ),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String address = _addressController.text;
                    final String phoneNo = _phoneNoController.text;

                    if (name.isNotEmpty) {
                      await clientss.doc(documentSnapshot!.id).update({
                        "clientName": name,
                        "clientAddress": address,
                        "phoneNo": phoneNo,
                      });
                      _nameController.text = '';
                      _addressController.text = '';
                      _phoneNoController.text = '';
                      Navigator.of(context).pop();
                      Helper.showSnackBar(
                          msg: LocaleKeys.updatedSuccessfully_Msg.tr(),
                          context: context);
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  /// ============================================  For Clients =============================================== ///

  /// ============================================  For worker =============================================== ///
  // =========== Delete Record For Clients =================== //
  Future<void> _deleteWorker(String id) async {
    await workerInvoice.doc(id).delete();
    Helper.showToast(LocaleKeys.deletedSuccessfullyMsg_text.tr());
  }

  Future<void> _updateWorker([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameWorkerController.text = documentSnapshot['workerClientName'];
      _addressWorkerController.text =
          documentSnapshot['workerClientAddress'].toString();
      _phoneNoWorkerController.text = documentSnapshot['phoneNo'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameWorkerController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.workerName_txt.tr(),
                  ),
                ),
                TextField(
                  controller: _addressWorkerController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.address_txt.tr(),
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _phoneNoWorkerController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phoneNumber_txt.tr(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(LocaleKeys.update_txt.tr()),
                  onPressed: () async {
                    final String name = _nameWorkerController.text;
                    final String address = _addressWorkerController.text;
                    final String phoneNo = _phoneNoWorkerController.text;

                    if (name.isNotEmpty) {
                      await workerInvoice.doc(documentSnapshot!.id).update({
                        "workerClientName": name,
                        "workerClientAddress": address,
                        "phoneNo": phoneNo,
                      });
                      _nameWorkerController.text = '';
                      _addressWorkerController.text = '';
                      _phoneNoWorkerController.text = '';
                      Navigator.of(context).pop();
                      Helper.showSnackBar(
                          msg: LocaleKeys.updatedSuccessfully_Msg.tr(),
                          context: context);
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  /// ============================================  For worker =============================================== ///

  /// ============================================  For worker =============================================== ///
  // =========== Delete Record For Clients =================== //
  Future<void> _deletePreviousInvoices(String id) async {
    await previousInvoice.doc(id).delete();
    Helper.showToast(LocaleKeys.deletedSuccessfullyMsg_text.tr());
  }

  Future<void> _updatePreviousInvoices(
      [DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['clientName'];
      _addressController.text = documentSnapshot['clientAddress'].toString();
      _phoneNoController.text = documentSnapshot['phoneNo'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Client Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _phoneNoController,
                  decoration: const InputDecoration(
                    labelText: 'Phone No',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String address = _addressController.text;
                    final String phoneNo = _phoneNoController.text;

                    if (name.isNotEmpty) {
                      await clientss.doc(documentSnapshot!.id).update({
                        "clientName": name,
                        "clientAddress": address,
                        "phoneNo": phoneNo,
                      });
                      _nameController.text = '';
                      _addressController.text = '';
                      _phoneNoController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  /// ============================================  For worker =============================================== ///

}
