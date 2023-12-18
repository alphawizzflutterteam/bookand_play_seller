// To parse this JSON data, do
//
//     final transactionHistory = transactionHistoryFromJson(jsonString);

import 'dart:convert';

TransactionHistory transactionHistoryFromJson(String str) => TransactionHistory.fromJson(json.decode(str));

String transactionHistoryToJson(TransactionHistory data) => json.encode(data.toJson());

class TransactionHistory {
  bool status;
  String message;
  List<Datum> data;

  TransactionHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int userId;
  int amount;
  dynamic description;
  String accountName;
  String acountNumber;
  String ifscCode;
  int isApprove;
  dynamic approvedBy;
  dynamic comment;
  dynamic approvedDate;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.accountName,
    required this.acountNumber,
    required this.ifscCode,
    required this.isApprove,
    required this.approvedBy,
    required this.comment,
    required this.approvedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    description: json["description"],
    accountName: json["account_name"],
    acountNumber: json["acount_number"],
    ifscCode: json["ifsc_code"],
    isApprove: json["is_approve"],
    approvedBy: json["approved_by"],
    comment: json["comment"],
    approvedDate: json["approved_date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "description": description,
    "account_name": accountName,
    "acount_number": acountNumber,
    "ifsc_code": ifscCode,
    "is_approve": isApprove,
    "approved_by": approvedBy,
    "comment": comment,
    "approved_date": approvedDate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
