
class NotificationModel {
  bool status;
  String message;
  List<Datum> data;

  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  int customerId;
  String message;
  int isRead;
  DateTime createdAt;
  DateTime updatedAt;
  String title;

  Datum({
    required this.id,
    required this.customerId,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    message: json["message"],
    isRead: json["isRead"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "message": message,
    "isRead": isRead,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
  };
}
