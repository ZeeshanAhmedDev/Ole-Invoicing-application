// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ole_app/screens/NewFinalScreen/InvoiceScreens/pdfGenerationForInvoiceCreation/PdfInvoiceApi.dart';
// import 'package:ole_app/screens/NewFinalScreen/InvoiceScreens/pdfGenerationForInvoiceCreation/fileHandler.dart';
// import 'package:ole_app/screens/NewFinalScreen/SelectCategories/selectCategoriesModel.dart';
// import 'package:ole_app/translations/locale_keys.g.dart';
// import 'package:text_scroll/text_scroll.dart';
// import '../../../custom_widgets/Container_btn_with_gradient.dart';
// import '../../../custom_widgets/appbar.dart';
// import '../../../utils/controllers.dart';
// import '../../../utils/helper.dart';
// import 'create_invoice_screen.dart';
// import 'newInvoiceDataModel.dart';
//
// class InvoicePreviewScreen extends StatefulWidget {
//   var name, startTime, endTime, showDate, decription, showTime, perHourRate;
//   InvoicePreviewScreen(
//       // List<DataModelForInvoice> dataModelForInvoice,
//       // List<DataModelForInvoice> dataModelForInvoice,
//       {
//     Key? key,
//     this.name,
//     this.startTime,
//     this.endTime,
//     this.showDate,
//     this.decription,
//     this.showTime,
//     this.perHourRate,
//   }) : super(key: key);
//
//   @override
//   _InvoicePreviewScreenState createState() => _InvoicePreviewScreenState();
// }
//
// class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
//   final List<DataModelForInvoice> dataModelForInvoice = [];
//
//   @override
//   void dispose() {
//     Helper.dropdownNames.clear();
//
//     super.dispose();
//   }
//
//   // ===================================
//   var distinctIdsfordropdownNames = [
//     ...{...Helper.dropdownNames}
//   ];
//   var distinctIdsfordropdownNamesForWorkers = [
//     ...{...Helper.dropdownNamesForWorkers}
//   ];
//
//   late CheckBoxSettingsForCategoriesModel settingsModel;
//   final myStyle = TextStyle(
//     fontWeight: FontWeight.w600,
//     fontSize: 22.sp,
//   );
//
//   final myTotalStyle = TextStyle(
//     fontWeight: FontWeight.w700,
//     fontSize: 30.sp,
//   );
//   var listItems = Helper.selectedItems.toString().replaceAll('[', '');
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Helper.onWillPopFunc(
//         context: context,
//         className: CreateInvoiceScreenNew(),
//       ),
//       child: Scaffold(
//         appBar: CustomAppBar(
//             // title: 'Invoice Preview',
//             title: LocaleKeys.invoice_preview_txt.tr(),
//             fun: () => Navigator.pushReplacement(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => CreateInvoiceScreenNew(),
//                 )),
//             elevation: 0),
//         body: SizedBox(
//           height: 1.sh,
//           width: 1.sw,
//           child: Padding(
//             padding: EdgeInsets.only(left: 40.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             "${LocaleKeys.receiver_name_txt.tr()}: ",
//                             style: myStyle,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                             width: 200.w,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               itemCount: distinctIdsfordropdownNames.length,
//                               itemBuilder: (context, index) {
//                                 return distinctIdsfordropdownNames.isNotEmpty
//                                     ? Padding(
//                                         padding:
//                                             EdgeInsets.fromLTRB(2.w, 0, 0, 0),
//                                         child: TextScroll(
//                                           distinctIdsfordropdownNames[index],
//                                           mode: TextScrollMode.bouncing,
//                                           velocity: const Velocity(
//                                               pixelsPerSecond: Offset(150, 0)),
//                                           delayBefore:
//                                               const Duration(milliseconds: 500),
//                                           numberOfReps: 5,
//                                           pauseBetween:
//                                               const Duration(milliseconds: 50),
//                                           // style: const TextStyle(
//                                           //     color: Colors.green),
//                                           textAlign: TextAlign.right,
//                                           // selectable: true,
//                                         ),
//                                       )
//                                     : const SizedBox();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "${LocaleKeys.workerName.tr()}: ",
//                             style: myStyle,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                             width: 215.w,
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: distinctIdsfordropdownNamesForWorkers
//                                     .length,
//                                 itemBuilder: (context, index) {
//                                   return distinctIdsfordropdownNamesForWorkers
//                                           .isNotEmpty
//                                       ? Padding(
//                                           padding:
//                                               EdgeInsets.fromLTRB(2.w, 0, 0, 0),
//                                           child: TextScroll(
//                                             distinctIdsfordropdownNamesForWorkers[
//                                                 index],
//                                             mode: TextScrollMode.bouncing,
//                                             velocity: const Velocity(
//                                                 pixelsPerSecond:
//                                                     Offset(150, 0)),
//                                             delayBefore: const Duration(
//                                                 milliseconds: 500),
//                                             numberOfReps: 5,
//                                             pauseBetween: const Duration(
//                                                 milliseconds: 50),
//                                             textAlign: TextAlign.right,
//                                           ),
//                                         )
//                                       : const SizedBox();
//                                 }),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "${LocaleKeys.invoice_number_txt.tr()}: ",
//                             style: myStyle,
//                           ),
//                           Text(
//                             ControllersTextFields
//                                 .instance.invoiceNoController.text,
//                           ),
//                           // Text("81230"),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "${LocaleKeys.invoiceDate_txt.tr()}: ",
//                             style: myStyle,
//                           ),
//                           Text(
//                             Helper.getCurrentDate(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "${LocaleKeys.week_ending_date.tr()}: ",
//                             style: myStyle,
//                           ),
//                           Text(DateFormat('dd-MM-yyyy').format(DateTime.now())),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "${LocaleKeys.description_txt.tr()}: ",
//                             style: myTotalStyle,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: const [
//                           Text(
//                             "Demolition: 150",
//                             // style: myStyle,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Row(
//                         children: const [
//                           Text(
//                             "Plumb and line: 150",
//                             // style: myStyle,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: SizedBox(
//           height: 100.h,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     CustomContainerButton(
//                       text: LocaleKeys.downloadInvoice_text.tr(),
//                       onPressed: () async {
//                         ///
//
//                         for (var element
//                             in distinctIdsfordropdownNamesForWorkers) {
//                           // generate pdf file
//
//                           final pdfFile =
//                               await PdfInvoiceApiForInvoice.generate(
//                             dataModelForInvoice,
//                             // weekEndingDate:
//                             //     dataModelForInvoice.first.weekEndingDate,
//                             // name: dataModelForInvoice.first.name,
//                             // description: dataModelForInvoice.first.name,
//                             // amountBilled: dataModelForInvoice.first.name,
//                             // invoiceNo: ControllersTextFields
//                             //     .instance.invoiceNoController.text,
//                             // workerLength: element.length,
//                           );
//
//                           // opening the pdf file
//                           setState(() {
//                             FileHandleApiForInvoice.openFile(pdfFile);
//                           });
//                         }
//
//                         // Helper.calcWorkHours(widget.startTime, widget.endTime);
//                         // final date = DateTime.now();
//                         // final dueDate = date.add(const Duration(days: 7));
//                         // final invoice = Invoice(
//                         //   supplier: Supplier(
//                         //       name: "AHmed",
//                         //       address: "karachi, johar town",
//                         //       paymentInfo: "sddddddddd"),
//                         //   customer: Customer(
//                         //     name: "AHmed",
//                         //     address: "karachi, johar town",
//                         //   ),
//                         //   info: InvoiceInfo(
//                         //     date: date,
//                         //     dueDate: dueDate,
//                         //     description: "sddddddddddd",
//                         //     number: "${DateTime.now().year}-9999",
//                         //   ),
//                         //   items: [
//                         //     InvoiceItem(
//                         //       description: "Coffe",
//                         //       date: DateTime.now(),
//                         //       quantity: 3,
//                         //       vat: 0.19,
//                         //       unitPrice: 5.99,
//                         //     ),
//                         //     InvoiceItem(
//                         //       description: "Water",
//                         //       date: DateTime.now(),
//                         //       quantity: 3,
//                         //       vat: 0.19,
//                         //       unitPrice: 5.99,
//                         //     ),
//                         //     InvoiceItem(
//                         //       description: "Orange",
//                         //       date: DateTime.now(),
//                         //       quantity: 3,
//                         //       vat: 0.19,
//                         //       unitPrice: 5.99,
//                         //     ),
//                         //   ],
//                         // );
//                         // final pdfFile = await PdfInvoiceApi.generate(invoice);
//                         // PdfApi.openFile(pdfFile);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// // Future openFile(File file) async {
// //   final url = file.path;
// //
// //   await openFile.open(url);
// // }
// }
