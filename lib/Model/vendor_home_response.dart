// To parse this JSON data, do
//
//     final vendorHomeResponse = vendorHomeResponseFromJson(jsonString);

import 'dart:convert';

VendorHomeResponse vendorHomeResponseFromJson(String str) => VendorHomeResponse.fromJson(json.decode(str));

String vendorHomeResponseToJson(VendorHomeResponse data) => json.encode(data.toJson());

class VendorHomeResponse {
  bool status;
  String message;
  Data data;

  VendorHomeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VendorHomeResponse.fromJson(Map<String, dynamic> json) => VendorHomeResponse(
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
  Booking totalBooking;
  Booking previousBooking;
  Booking upcomingBooking;
  TotalEarning totalEarning;

  Data({
    required this.totalBooking,
    required this.previousBooking,
    required this.upcomingBooking,
    required this.totalEarning,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalBooking: Booking.fromJson(json["total_booking"]),
    previousBooking: Booking.fromJson(json["previous_booking"]),
    upcomingBooking: Booking.fromJson(json["upcoming_booking"]),
    totalEarning: TotalEarning.fromJson(json["total_earning"]),
  );

  Map<String, dynamic> toJson() => {
    "total_booking": totalBooking.toJson(),
    "previous_booking": previousBooking.toJson(),
    "upcoming_booking": upcomingBooking.toJson(),
    "total_earning": totalEarning.toJson(),
  };
}

class Booking {
  int count;
  List<PreviousBookingDetail> details;

  Booking({
    required this.count,
    required this.details,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    count: json["count"],
    details: List<PreviousBookingDetail>.from(json["details"].map((x) => PreviousBookingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class PreviousBookingDetail {
  int id;
  int userId;
  int groundId;
  int vendorId;
  int isApprove;
  DateTime bookingDate;
  String bookingFrom;
  String bookingTo;
  String? bookingName;
  dynamic bookingEmail;
  dynamic bookingMobile;
  int bookingCancelStatus;
  String? email;
  String? bookingMobileNo;
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
  dynamic groundTitle;

  PreviousBookingDetail({
    required this.id,
    required this.userId,
    required this.groundId,
    required this.vendorId,
    required this.isApprove,
    required this.bookingDate,
    required this.bookingFrom,
    required this.bookingTo,
    required this.bookingName,
    required this.bookingEmail,
    required this.bookingMobile,
    required this.bookingCancelStatus,
    required this.email,
    required this.bookingMobileNo,
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
    required this.groundTitle,
  });

  factory PreviousBookingDetail.fromJson(Map<String, dynamic> json) => PreviousBookingDetail(
    id: json["id"],
    userId: json["user_id"]==null?0:json["user_id"],
    groundId: json["ground_id"],
    vendorId: json["vendor_id"],
    isApprove: json["is_approve"],
    bookingDate: DateTime.parse(json["booking_date"]),
    bookingFrom: json["booking_from"],
    bookingTo: json["booking_to"],
    bookingName: json["booking_name"],
    bookingEmail: json["booking_email"],
    bookingMobile: json["booking_mobile"],
    bookingCancelStatus: json["booking_cancel_status"],
    email: json["email"],
    bookingMobileNo: json["booking_mobile_no"],
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
    groundTitle: json["ground_title"],
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
    "booking_email": bookingEmail,
    "booking_mobile": bookingMobile,
    "booking_cancel_status": bookingCancelStatus,
    "email": email,
    "booking_mobile_no": bookingMobileNo,
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
    "ground_title": groundTitle,
  };
}

class TotalEarning {
  int count;
  List<TotalEarningDetail> details;

  TotalEarning({
    required this.count,
    required this.details,
  });

  factory TotalEarning.fromJson(Map<String, dynamic> json) => TotalEarning(
    count: json["count"],
    details: List<TotalEarningDetail>.from(json["details"].map((x) => TotalEarningDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TotalEarningDetail {
  int bookingId;
  dynamic grountTitle;
  DateTime bookingDate;
  int amount;

  TotalEarningDetail({
    required this.bookingId,
    required this.grountTitle,
    required this.bookingDate,
    required this.amount,
  });

  factory TotalEarningDetail.fromJson(Map<String, dynamic> json) => TotalEarningDetail(
    bookingId: json["booking_id"],
    grountTitle: json["grount_title"],
    bookingDate: DateTime.parse(json["booking_date"]),
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "grount_title": grountTitle,
    "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
    "amount": amount,
  };
}
