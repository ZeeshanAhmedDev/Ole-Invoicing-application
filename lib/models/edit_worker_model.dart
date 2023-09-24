import 'package:cloud_firestore/cloud_firestore.dart';

class EditWorkerModel {
  final String workerClientName;
  final String workerClientAddress;
  DateTime dateTime;
  String id;
  final String phone;

  EditWorkerModel({
    required this.workerClientName,
    required this.workerClientAddress,
    this.id = '',
    required this.dateTime,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'workerClientName': workerClientName,
        'workerClientAddress': workerClientAddress,
        'createdAt': dateTime,
        'phoneNo': phone,
      };

  static EditWorkerModel fromJson(Map<String, dynamic> json) => EditWorkerModel(
        id: json['id'],
        workerClientName: json['workerClientName'],
        workerClientAddress: json['workerClientAddress'],
        dateTime: (json['createdAt']),
        phone: json['phoneNo'],
      );
}
