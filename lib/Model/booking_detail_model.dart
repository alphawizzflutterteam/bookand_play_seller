class BookingDetailModel {
  List<String>? image;
  String? groundTitle;
  String? address;
  int ?bookedByVendor;
  String? bookingName;
  String? email;
  String ?bookingEmail;
  String ?bookingMobile;
  String? mobile;
  String? bookingDate;
  String? bookingFrom;
  String? bookingTo;
  int? totalAmount;
  List<String>? facility;

  BookingDetailModel(
      {this.image,
        this.groundTitle,
        this.address,
        this.bookedByVendor,
        this.bookingName,
        this.email,
        this.mobile,
        this.bookingEmail,
        this.bookingMobile,
        this.bookingDate,
        this.bookingFrom,
        this.bookingTo,
        this.totalAmount,
        this.facility});

  BookingDetailModel.fromJson(Map<String, dynamic> json) {
    image = json['image'].cast<String>();
    groundTitle = json['ground_title'];
    address = json['address'];
    bookedByVendor = json['booked_by_vendor'];
    bookingName = json['booking_name'];
    email = json['email'];
    mobile = json['mobile'];
    bookingEmail = json['booking_email'];
    bookingMobile = json['booking_mobile'];
    bookingDate = json['booking_date'];
    bookingFrom = json['booking_from'];
    bookingTo = json['booking_to'];
    totalAmount = json['total_amount'];
    facility = json['facility'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['ground_title'] = this.groundTitle;
    data['address'] = this.address;
    data['booked_by_vendor'] = this.bookedByVendor;
    data['booking_name'] = this.bookingName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['booking_email'] = this.bookingEmail;
    data['booking_mobile'] = this.bookingMobile;

    data['booking_date'] = this.bookingDate;
    data['booking_from'] = this.bookingFrom;
    data['booking_to'] = this.bookingTo;
    data['total_amount'] = this.totalAmount;
    data['facility'] = this.facility;
    return data;
  }
}
