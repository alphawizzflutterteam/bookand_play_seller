class CancelBookingsDetailsModel {
  bool? status;
  String? message;
  CancelData? data;

  CancelBookingsDetailsModel({this.status, this.message, this.data});

  CancelBookingsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CancelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CancelData {
  List<String>? image;
  String? groundTitle;
  String? address;
  String? bookingName;
  String? bookingEmail;
  String? bookingMobile;
  String? bookingDate;
  String? bookingFrom;
  String? bookingTo;
  int? totalAmount;
  List<String>? facility;
  int? bookingCancelStatus;
  BookingCancelData? bookingCancelData;

  CancelData(
      {this.image,
        this.groundTitle,
        this.address,
        this.bookingName,
        this.bookingEmail,
        this.bookingMobile,
        this.bookingDate,
        this.bookingFrom,
        this.bookingTo,
        this.totalAmount,
        this.facility,
        this.bookingCancelStatus,
        this.bookingCancelData});

  CancelData.fromJson(Map<String, dynamic> json) {
    image = json['image'].cast<String>();
    groundTitle = json['ground_title'];
    address = json['address'];
    bookingName = json['booking_name'];
    bookingEmail = json['booking_email'];
    bookingMobile = json['booking_mobile'];
    bookingDate = json['booking_date'];
    bookingFrom = json['booking_from'];
    bookingTo = json['booking_to'];
    totalAmount = json['total_amount'];
    facility = json['facility'].cast<String>();
    bookingCancelStatus = json['booking_cancel_status'];
    bookingCancelData = json['booking_cancel_data'] != null
        ? new BookingCancelData.fromJson(json['booking_cancel_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['ground_title'] = this.groundTitle;
    data['address'] = this.address;
    data['booking_name'] = this.bookingName;
    data['booking_email'] = this.bookingEmail;
    data['booking_mobile'] = this.bookingMobile;
    data['booking_date'] = this.bookingDate;
    data['booking_from'] = this.bookingFrom;
    data['booking_to'] = this.bookingTo;
    data['total_amount'] = this.totalAmount;
    data['facility'] = this.facility;
    data['booking_cancel_status'] = this.bookingCancelStatus;
    if (this.bookingCancelData != null) {
      data['booking_cancel_data'] = this.bookingCancelData!.toJson();
    }
    return data;
  }
}

class BookingCancelData {
  int? id;
  int? bookingId;
  int? userId;
  int? vendorId;
  int? approveByVendor;
  int? approveByAdmin;
  String? cancelReason;
  Null? comment;
  String? createdAt;
  String? updatedAt;

  BookingCancelData(
      {this.id,
        this.bookingId,
        this.userId,
        this.vendorId,
        this.approveByVendor,
        this.approveByAdmin,
        this.cancelReason,
        this.comment,
        this.createdAt,
        this.updatedAt});

  BookingCancelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    approveByVendor = json['approve_by_vendor'];
    approveByAdmin = json['approve_by_admin'];
    cancelReason = json['cancel_reason'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['user_id'] = this.userId;
    data['vendor_id'] = this.vendorId;
    data['approve_by_vendor'] = this.approveByVendor;
    data['approve_by_admin'] = this.approveByAdmin;
    data['cancel_reason'] = this.cancelReason;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
