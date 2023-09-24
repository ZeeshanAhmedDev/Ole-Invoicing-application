import 'package:cloud_firestore/cloud_firestore.dart';

class AddWorkDescriptionModel {
  final String workDescription;
  final String costCode;
  var id;
  DateTime dateTime;

  AddWorkDescriptionModel({
    required this.workDescription,
    required this.costCode,
    this.id = '',
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'workDescription': workDescription,
        'cost-code': costCode,
        'createdAt': dateTime,
      };

  static AddWorkDescriptionModel fromJson(Map<String, dynamic> json) =>
      AddWorkDescriptionModel(
          id: json['id'],
          dateTime: (json['createdAt'] as Timestamp).toDate(),
          costCode: json['workDescription'],
          workDescription: json['cost-code']);
}
