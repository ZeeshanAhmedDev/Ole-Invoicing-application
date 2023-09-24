// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// Widget CustomDropDownWidget(
//     {required String onChangeValue,
//     required String text,
//     required List<String> dropDownListOfData,
//     bool isActive = true}) {
//   return Container(
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: Color(0xff6FC4DB),
//       ), // red as border color
//       color: Color(0xff6FC4DB).withOpacity(0.06),
//       borderRadius: BorderRadius.circular(15.r),
//     ),
//     width: 368.w,
//
//     // padding: const EdgeInsets.all(0.0),
//     child: DropdownButtonHideUnderline(
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(left: 20.0.w),
//           enabledBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.transparent)),
//           focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.transparent)),
//           // isDense: true,
//         ),
//         validator: (value) {
//           if (value?.isEmpty ?? true) {
//             return 'Industry cannot be empty';
//           }
//           return null;
//         },
//         icon: Padding(
//           padding: EdgeInsets.only(right: 18.w),
//           child: const Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: Color(0xff6FC4DB),
//           ),
//         ),
//         isExpanded: true,
//         value: onChangeValue,
//         style: const TextStyle(
//             // fontWeight: FontWeight.w500,
//             color: Color(0xff6FC4DB)),
//         items: dropDownListOfData.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: dropDownListOfData.isNotEmpty ? value : null,
//             child: Padding(
//               padding: EdgeInsets.only(left: 27.w),
//               child: Text(
//                 value,
//                 style: TextStyle(color: Color(0xff6FC4DB), fontSize: 17.sp),
//               ),
//             ),
//           );
//         }).toList(),
//         hint: Padding(
//           padding: EdgeInsets.only(left: 5.w),
//           child: Text(
//             text,
//             style: TextStyle(color: const Color(0xff6FC4DB), fontSize: 17.sp),
//           ),
//         ),
//         onChanged: (String? value) {
//           // setState(() {
//           onChangeValue = value!;
//           // });
//         },
//       ),
//     ),
//   );
// }
