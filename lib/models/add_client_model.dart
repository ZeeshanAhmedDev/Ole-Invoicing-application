import 'package:cloud_firestore/cloud_firestore.dart';

class AddClientInformation {
  final String clientName;
  // final List<String>  clientName;
  final String clientAddress;
  final String phone;
  String id;
  DateTime dateTime;

  AddClientInformation({
    required this.clientName,
    required this.clientAddress,
    required this.phone,
    this.id = '',
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientName': clientName,
        'clientAddress': clientAddress,
        'phoneNo': phone,
        'createdAt': dateTime,
      };

  static AddClientInformation fromJson(Map<String, dynamic> json) =>
      AddClientInformation(
        id: json['id'],
        clientName: json['clientName'],
        clientAddress: json['clientAddress'],
        phone: json['phoneNo'],
        dateTime: (json['createdAt'] as Timestamp).toDate(),
      );
}
