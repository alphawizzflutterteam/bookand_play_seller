
class WalletHistory {
  bool status;
  String message;
  Data data;

  WalletHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
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
  List<Transaction> transactions;

  Data({
    required this.wallet,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wallet: json["wallet"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  int id;
  String transactionId;
  int userId;
  String paymentType;
  String transactionType;
  int amount;
  String remark;
  String destination;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    required this.id,
    required this.transactionId,
    required this.userId,
    required this.paymentType,
    required this.transactionType,
    required this.amount,
    required this.remark,
    required this.destination,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    transactionId: json["transaction_id"],
    userId: json["user_id"],
    paymentType: json["payment_type"],
    transactionType: json["transaction_type"],
    amount: json["amount"],
    remark: json["remark"],
    destination: json["destination"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "user_id": userId,
    "payment_type": paymentType,
    "transaction_type": transactionType,
    "amount": amount,
    "remark": remark,
    "destination": destination,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
