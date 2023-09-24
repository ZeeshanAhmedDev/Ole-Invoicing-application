import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousInvoicesModel {
  String id;
  final List<String?> name;
  final DateTime dateTime;
  final String invoiceNo;
  // final String price;

  PreviousInvoicesModel({
    this.id = '',
    required this.name,
    required this.dateTime,
    required this.invoiceNo,
    // required this.price,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientName': name,
        // 'invoiceDate': clientAddress,
        'invoiceNo': invoiceNo,
        'createdAt': dateTime,
      };

  static PreviousInvoicesModel fromJson(Map<String, dynamic> json) =>
      PreviousInvoicesModel(
        id: json['id'],
        name: json['clientName'],
        invoiceNo: json['invoiceNo'],
        dateTime: (json['createdAt'] as Timestamp).toDate(),
      );
}
