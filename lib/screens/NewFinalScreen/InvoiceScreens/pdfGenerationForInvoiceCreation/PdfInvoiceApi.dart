import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ole_app/screens/NewFinalScreen/SelectCategories/selectCategoriesModel.dart';
import 'package:ole_app/utils/helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../TimeSheetScreen/pdfGenerationForTimeSheet/fileHandler.dart';
import '../newInvoiceDataModel.dart';

class PdfInvoiceApiForInvoice {
  static Future<File> generate(
    List<DataModelForInvoice> dataModelForInvoice,
    List<CheckBoxSettingsForCategoriesModel> checkBoxSettingsForCategoriesModel,
    //     {
    //   var weekEndingDate,
    //   var workerLength,
    //   var name,
    //   var description,
    //   var supplies,
    //   var amountBilled,
    //   var invoiceNo,
    // }
  ) async {
    final pdf = pw.Document();

    final tableHeaders = [
      'Item         Date',
      'Description',
      'Supplies',
      'Amt Billed',
    ];

    var purchasesAsMap = <Map<dynamic, dynamic>>[
      for (int i = 0; i < dataModelForInvoice.length; i++)
        {
          "Item": dataModelForInvoice.length.toString() +
              "              " +
              Helper.dropdownNamesForWorkers[i] +
              "\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +
              "${DateFormat('yMMMMEEEEd').format(DateTime.parse(dataModelForInvoice[i].weekEndingDate.toString()))} " +
              "",
          "Description": " " + Helper.strListOfCategories[i].discription,
          "Supplies": "\$${Helper.strListOfCategories[i].supplies}",
          'Amt Billed': "\$${Helper.strListOfCategories[i].amtBilled}",
        },
    ];

    List<List<dynamic>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'To:',
                    ),
                    pw.Text(
                      Helper.dropdownNames
                          .toSet()
                          .toString()
                          .replaceAll("{", '')
                          .replaceAll('}', ''),
                    ),
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
                          '${dataModelForInvoice[0].invoiceNumber}',
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
              // (
              // // bottom: pw.BorderSide(style: pw.BorderStyle.solid),
              // // left: pw.BorderSide(style: pw.BorderStyle.solid),
              // // horizontalInside: pw.BorderSide(
              // //   style: pw.BorderStyle.solid,
              // // ),
              // // verticalInside: pw.BorderSide(
              // //   style: pw.BorderStyle.solid,
              // // ),
              // ),
              border: pw.TableBorder.all(color: PdfColors.black),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              // headerDecoration:
              //     const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 31.0.h,
              cellPadding: pw.EdgeInsets.all(10.r),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
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
              oddRowDecoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor.fromInt(0xFF000000),
                  width: 1,
                ),
              ),
              cellStyle: pw.TextStyle(
                fontSize: 12.h,
              ),
            ),
            // pw.Divider(),
            pw.SizedBox(height: 20.h),
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
                            pw.Text(
                              // '\$ 464',
                              '\$ ${checkBoxSettingsForCategoriesModel[0].totalAmountOfAmountBilled}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                            pw.Text(
                              '\$ 90.48',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                            pw.SizedBox(height: 10.h),
                            pw.Container(
                              height: 1,
                              width: 50.w,
                              color: PdfColors.black,
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total Due',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              '\$ 554.48',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        // footer: (context) {
        //   return pw.Column(
        //     mainAxisSize: pw.MainAxisSize.min,
        //     children: [
        //       pw.Divider(),
        //       pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //       pw.Text(
        //         'Flutter Approach',
        //         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        //       ),
        //       pw.SizedBox(height: 1 * PdfPageFormat.mm),
        //       pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.center,
        //         children: [
        //           pw.Text(
        //             'Address: ',
        //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        //           ),
        //           pw.Text(
        //             'Merul Badda, Anandanagor, Dhaka 1212',
        //           ),
        //         ],
        //       ),
        //       pw.SizedBox(height: 1 * PdfPageFormat.mm),
        //       pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.center,
        //         children: [
        //           pw.Text(
        //             'Email: ',
        //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        //           ),
        //           pw.Text(
        //             'flutterapproach@gmail.com',
        //           ),
        //         ],
        //       ),
        //     ],
        //   );
        // },
      ),
    );

    return FileHandleApi.saveDocument(name: 'Invoice.pdf', pdf: pdf);
  }
}
