// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import '../custom_widgets/Container_btn_with_gradient.dart';
// import '../custom_widgets/appbar.dart';
// import '../utils/controllers.dart';
// import '../utils/helper.dart';
// import '../utils/string_resource.dart';
// import 'menu_screen.dart';
//
// class InvoicePreviewScreen extends StatefulWidget {
//   const InvoicePreviewScreen({Key? key}) : super(key: key);
//
//   @override
//   _InvoicePreviewScreenState createState() => _InvoicePreviewScreenState();
// }
//
// class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
//   final myStyle = TextStyle(
//     fontWeight: FontWeight.w600,
//     fontSize: 22.sp,
//   );
//   var listItems = Helper.selectedItems.toString().replaceAll('[', '');
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Helper.onWillPopFunc(
//         context: context,
//         className: const MenuScreen(),
//       ),
//       child: Scaffold(
//         appBar: CustomAppBar(
//             title: 'Invoice Preview',
//             fun: () => Navigator.pushReplacement(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => const MenuScreen(),
//                 )),
//             elevation: 0),
//         body: Container(
//           height: 1.sh,
//           width: 1.sw,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           "Receiver Name: ",
//                           style: myStyle,
//                         ),
//                         Text(
//                           listItems.toString().replaceAll(']', ''),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Worker Name: ",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 25.sp,
//                           ),
//                         ),
//                         Text(
//                           listItems.toString().replaceAll(']', ''),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Invoice#: ",
//                           style: myStyle,
//                         ),
//                         Text(
//                           ControllersTextFields
//                               .instance.invoiceNoController.text,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Invoice Date: ",
//                           style: myStyle,
//                         ),
//                         Text(
//                           Helper.getCurrentDate(context),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Week Ending Date: ",
//                           style: myStyle,
//                         ),
//                         Text(Helper.showDateOfCalender != null
//                             ? DateFormat('d-M-yyyy')
//                                 .format(Helper.showDateOfCalender)
//                             : Helper.convertDateTimeDisplay(
//                                 DateTime.now().toString())),
//                       ],
//                     ),
//                     Helper.customSizedBox,
//                     Helper.listForDynamicWidgets.isNotEmpty
//                         ? Container(
//                             color: Colors.transparent,
//                             margin: EdgeInsets.all(5.0.r),
//                             // height: 295.0.h,
//                             width: 355.0.w,
//                             child: Container(
//                               // height: 400.h,
//                               child: ListView.separated(
//                                   physics: const BouncingScrollPhysics(),
//                                   separatorBuilder: (context, index) {
//                                     return Divider(
//                                       // thickness: 2,
//                                       color: Colors.transparent,
//                                       height: 40.h,
//                                     );
//                                   },
//                                   scrollDirection: Axis.vertical,
//                                   shrinkWrap: true,
//                                   itemCount:
//                                       Helper.listForDynamicWidgets.length,
//                                   itemBuilder: (context, index) {
//                                     return Helper.listForDynamicWidgets[index];
//                                   }),
//                             ),
//                           )
//                         : SizedBox(
//                             height: 80.h,
//                           ),
//                     SizedBox(
//                       height: 40.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: SizedBox(
//           height: 70.h,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     CustomContainerButton(
//                       text: StringResource.downloadButtonText,
//                       onPressed: () {
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     CupertinoPageRoute(
//                         //       builder: (context) =>
//                         //           const InvoicePreviewScreen(),
//                         //     ));
//                         Helper.showSnackBar(
//                             context: context,
//                             msg: 'Invoice downloaded successfully');
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
// }
