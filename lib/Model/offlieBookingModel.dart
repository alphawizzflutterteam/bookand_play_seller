// To parse this JSON data, do
//
//     final offlineBookingModel = offlineBookingModelFromJson(jsonString);

import 'dart:convert';

OfflineBookingModel offlineBookingModelFromJson(String str) => OfflineBookingModel.fromJson(json.decode(str));

String offlineBookingModelToJson(OfflineBookingModel data) => json.encode(data.toJson());

class OfflineBookingModel {
  bool status;
  String message;
  List<Datum> data;

  OfflineBookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OfflineBookingModel.fromJson(Map<String, dynamic> json) => OfflineBookingModel(
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
  dynamic userId;
  int groundId;
  int vendorId;
  int isApprove;
  int bookedByVendor;
  DateTime bookingDate;
  String bookingFrom;
  String bookingTo;
  dynamic bookingName;
  dynamic bookingEmail;
  dynamic bookingMobile;
  int bookingCancelStatus;
  dynamic email;
  dynamic bookingMobileNo;
  dynamic arrivalTime;
  dynamic bookingHours;
  int groundRate;
  int addCommission;
  dynamic subTotal;
  dynamic couponId;
  dynamic discount;
  int totalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  String address;
  String title;

  Datum({
    required this.id,
    required this.userId,
    required this.groundId,
    required this.vendorId,
    required this.isApprove,
    required this.bookedByVendor,
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
    required this.address,
    required this.title,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"]==null?0:json["user_id"],
    groundId: json["ground_id"],
    vendorId: json["vendor_id"],
    isApprove: json["is_approve"],
    bookedByVendor: json["booked_by_vendor"],
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
    updatedAt: DateTime.parse(json["updated_at"]),
    address: json["address"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ground_id": groundId,
    "vendor_id": vendorId,
    "is_approve": isApprove,
    "booked_by_vendor": bookedByVendor,
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
    "updated_at": updatedAt.toIso8601String(),
    "address": address,
    "title": title,
  };
}
