// To parse this JSON data, do
//
//     final bookingHistory = bookingHistoryFromJson(jsonString);


class BookingHistory {
  bool status;
  String message;
  List<DataNew> data;

  BookingHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
    status: json["status"],
    message: json["message"],
    data: List<DataNew>.from(json["data"].map((x) => DataNew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataNew {
  int id;
  int userId;
  int groundId;
  int vendorId;
  int isApprove;
  DateTime bookingDate;
  String bookingFrom;
  String bookingTo;
  String? bookingName;
  dynamic arrivalTime;
  int? bookingHours;
  int groundRate;
  int addCommission;
  dynamic subTotal;
  dynamic couponId;
  dynamic discount;
  int totalAmount;
  DateTime createdAt;
  DateTime? updatedAt;
  String address;
  String title;

  DataNew({
    required this.id,
    required this.userId,
    required this.groundId,
    required this.vendorId,
    required this.isApprove,
    required this.bookingDate,
    required this.bookingFrom,
    required this.bookingTo,
    required this.bookingName,
    required this.arrivalTime,
    required this.bookingHours,
    required this.groundRate,
    required this.addCommission,
    required this.subTotal,
    required this.couponId,
    required this.discount,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.title,
  });

  factory DataNew.fromJson(Map<String, dynamic> json) => DataNew(
    id: json["id"],
    userId: json["user_id"]==null?0:json["user_id"],
    groundId: json["ground_id"],
    vendorId: json["vendor_id"],
    isApprove: json["is_approve"],
    bookingDate: DateTime.parse(json["booking_date"]),
    bookingFrom: json["booking_from"],
    bookingTo: json["booking_to"],
    bookingName: json["booking_name"],
    arrivalTime: json["arrival_time"],
    bookingHours: json["booking_hours"],
    groundRate: json["ground_rate"],
    addCommission: json["add_commission"],
    subTotal: json["sub_total"],
    couponId: json["coupon_id"],
    discount: json["discount"],
    totalAmount: json["total_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    address: json["address"].toString(),
    title: json["title"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ground_id": groundId,
    "vendor_id": vendorId,
    "is_approve": isApprove,
    "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
    "booking_from": bookingFrom,
    "booking_to": bookingTo,
    "booking_name": bookingName,
    "arrival_time": arrivalTime,
    "booking_hours": bookingHours,
    "ground_rate": groundRate,
    "add_commission": addCommission,
    "sub_total": subTotal,
    "coupon_id": couponId,
    "discount": discount,
    "total_amount": totalAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "address": address,
    "title": title,
  };
}
