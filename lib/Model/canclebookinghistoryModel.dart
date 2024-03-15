
class CancleBookingHistory {
  bool status;
  String message;
  List<Datum> data;

  CancleBookingHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CancleBookingHistory.fromJson(Map<String, dynamic> json) => CancleBookingHistory(
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
  int bookingId;
  int userId;
  int vendorId;
  int approveByVendor;
  int approveByAdmin;
  String? cancelReason;
  dynamic comment;
  DateTime createdAt;
  DateTime updatedAt;
  String? imggGround;

  Datum({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.vendorId,
    required this.approveByVendor,
    required this.approveByAdmin,
    required this.cancelReason,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.imggGround,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bookingId: json["booking_id"],
    userId: json["user_id"]==null?0:json["user_id"],
    vendorId: json["vendor_id"],
    approveByVendor: json["approve_by_vendor"],
    approveByAdmin: json["approve_by_admin"],
    cancelReason: json["cancel_reason"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    imggGround: json["groundimage"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "user_id": userId,
    "vendor_id": vendorId,
    "approve_by_vendor": approveByVendor,
    "approve_by_admin": approveByAdmin,
    "cancel_reason": cancelReason,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "groundimage": imggGround,

  };
}
