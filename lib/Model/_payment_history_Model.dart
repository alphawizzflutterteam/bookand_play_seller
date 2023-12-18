

class HistoryModel {
  bool status;
  String message;
  Data data;

  HistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int wallet;
  List<dynamic> transactions;

  Data({
    required this.wallet,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wallet: json["wallet"],
    transactions: json["transactions"]==null?[]:List<dynamic>.from(json["transactions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "transactions": List<dynamic>.from(transactions.map((x) => x)),
  };
}
