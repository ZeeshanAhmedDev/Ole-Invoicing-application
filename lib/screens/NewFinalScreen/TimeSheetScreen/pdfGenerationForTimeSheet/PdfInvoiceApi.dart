import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ole_app/utils/helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'data model.dart';
import 'fileHandler.dart';
import 'package:collection/collection.dart';

List<DataModelForTimeSheet> dataModelForTimeSheet = [];
// DataModelForTimeSheet? dataModelForTimeSheet;
var totalHourlyRate;

var sum;

class PdfInvoiceApi {
  static Future<File> generate(
      // {
      List<DataModelForTimeSheet> dataModelForTimeSheet
      // var weekEndingDate,
      // var name,
      // var hourlyRate,
      // var description,
      // var supplies,
      // var totalTime,
      // var invoiceNo,
      // totalLength,
      // var startTime,
      // var endTime,
      // }
      ) async {
    final pdf = pw.Document();

    // final iconImage = (await rootBundle.load('assets/png_images/Ole.png'))
    //     .buffer
    //     .asUint8List();

    final tableHeaders = [
      '',
      '',
      '',
      'Start',
      'Finish',
      'Total',
      'Supplies',
    ];

    // for (int i = 0; i < dataModelForTimeSheet.length; i++) {
    //   totalHourlyRate = (int.parse(dataModelForTimeSheet[i].hourlyRate)) *
    //       (int.parse(dataModelForTimeSheet[i].totalTime.sum));
    // }

    List<List<dynamic>> listOfPurchases = [];

    var purchasesAsMap = <Map<dynamic, dynamic>>[
      for (int i = 0; i < dataModelForTimeSheet.length; i++)
        {
          "name": dataModelForTimeSheet[i].name,
          "date": DateFormat('yMMMMEEEEd').format(DateTime.parse(
              dataModelForTimeSheet[i].weekEndingDate.toString())),
          "desc": dataModelForTimeSheet[i].description,
          'StartTIME': dataModelForTimeSheet[i].startTime,
          // 'dd': "5gf",
          'Finish': dataModelForTimeSheet[i].endTime,
          "Total":
              dataModelForTimeSheet[i].totalTime.toString().replaceAll('-', ''),
          "Supplies": "\$${dataModelForTimeSheet[i].supplies}",
        },
    ];

    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    ////////// =======================================
    // for (int i = 0; i < purchasesAsMap.length; i++) {
    //   listOfPurchases.add(purchasesAsMap[i].values.toList());
    // }
    ////////// =======================================

    pdf.addPage(
      pw.MultiPage(
        // crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        pageFormat: PdfPageFormat.a4,
        // margin: pw.EdgeInsets.all(12.h),
        build: (context) {
          return [
            pw.Row(
              // // crossAxisAlignment: pw.CrossAxisAlignment.start,
              // mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                // pw.Image(
                //   pw.MemoryImage(iconImage),
                //   height: 72,
                //   width: 72,
                // ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'To:',
                    ),
                    pw.Text(
                      Helper.dropdownNameListForSelectClientScreen
                          .toSet()
                          .toString()
                          .replaceAll("{", '')
                          .replaceAll('}', ''),
                    ),
                    // pw.Text(
                    //   '1400 Manera Ventosa',
                    // ),
                    // pw.Text(
                    //   'San Clemente CA 92673',
                    // ),
                  ],
                ),
                pw.SizedBox(width: 30 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'From:',
                    ),
                    pw.Text(
                      'Ole Invoicing',
                    ),
                    pw.Text(
                      'CA, USA',
                    ),
                    // pw.Text(
                    //   'San Clemente CA 92673',
                    // ),
                  ],
                ),
                pw.SizedBox(width: 35 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'Invoice# ',
                          style: pw.TextStyle(
                            fontSize: 16.w,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${dataModelForTimeSheet[0].invoiceNo}',
                          style: pw.TextStyle(
                            fontSize: 15.w,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    pw.Row(children: [
                      pw.Text(
                        'Week Ending Date ',
                        style: pw.TextStyle(
                          fontSize: 15.w,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        style: pw.TextStyle(
                          fontSize: 12.w,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ]),

                    // pw.Text(
                    //   DateTime.now().toString(),
                    // ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 8 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              // headers: null,
              data: listOfPurchases,
              border: const pw.TableBorder(
                bottom: pw.BorderSide(style: pw.BorderStyle.solid),
                // left: pw.BorderSide(style: pw.BorderStyle.solid),
                horizontalInside: pw.BorderSide(
                  style: pw.BorderStyle.solid,
                ),
                // verticalInside: pw.BorderSide(
                //   style: pw.BorderStyle.solid,
                // ),
              ),
              // headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              // headerDecoration:
              //     const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 31.0.h,
              cellPadding: pw.EdgeInsets.all(10.r),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
                4: pw.Alignment.center,
              },
              tableWidth: pw.TableWidth.max,
              rowDecoration: pw.BoxDecoration(
                // shape: pw.BoxShape.circle,
                border: pw.Border.all(
                  color: const PdfColor.fromInt(0xFF000000),
                  width: 1,
                  // style: pw.BorderStyle.dotted,
                ),
              ),
              // oddRowDecoration: pw.BoxDecoration(
              //   border: pw.Border.all(
              //     color: const PdfColor.fromInt(0xFF000000),
              //     width: 1,
              //   ),
              // )
              cellStyle: pw.TextStyle(
                fontSize: 10.h,
              ),
            ),
            // pw.Divider(),
            /// ================
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 15.h),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total Hours',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              dataModelForTimeSheet[0]
                                  .totalTimeAddition
                                  .toString(),
                              // totalHourlyRate.toString().replaceAll('-', ''),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 15.h),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Hourly Rate is:',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              '\$ ${dataModelForTimeSheet[0].hourlyRate}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // pw.Row(
                        //   children: [
                        //     pw.Expanded(
                        //       child: pw.Text(
                        //         '',
                        //         style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       '\$ 90.48',
                        //       style: pw.TextStyle(
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        pw.SizedBox(height: 15.h),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                '',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              height: 1,
                              width: 50.w,
                              color: PdfColors.black,
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 15.h),
                        // pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total due',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              '\$${dataModelForTimeSheet[0].sumOftotalTime}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        // pw.Container(height: 1, color: PdfColors.grey400),
                        // pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        // pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================
          ];
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'TimeSheet Invoice.pdf', pdf: pdf);
  }
}
