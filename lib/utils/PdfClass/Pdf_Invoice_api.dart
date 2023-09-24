// import 'dart:io';
// import 'package:ole_app/utils/PdfClass/save_document.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
//
// class PdfInvoiceApi {
//   static Future<File> generate(Invoice invoice) async {
//     final pdf = Document();
//     pdf.addPage(
//       MultiPage(
//         build: (context) => [
//           buildTitle(invoice),
//           buildInvoice(invoice),
//         ],
//       ),
//     );
//
//     return PdfApi.saveDocument(name: 'my_Invoice', pdf: pdf);
//   }
//
//   static Widget buildTitle(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('INVOICE'),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           Text(invoice.info.decription),
//         ],
//       );
//
//   static Widget buildInvoice(Invoice invoice) {
//     final headers = [
//       'Description',
//       'Data',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total',
//     ];
//
//     final data = invoice.items.map((item) {
//       final total = item.unitPrice * item.quantity * (1 + item.vat);
//       return [
//         item.description,
//       ];
//     }).toList();
//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//     );
//   }
// }
