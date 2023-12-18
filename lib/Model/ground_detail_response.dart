class GroundDetailResponse {
  bool? status;
  String? message;
  GroundDetailData? data;

  GroundDetailResponse({this.status, this.message, this.data});

  GroundDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GroundDetailData.fromJson(json['data']) : null;
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

class GroundDetailData {
  int? groundId;
  int? categoryId;
  int? vendorId;
  String? title;
  String? openingTime;
  String? closingTime;
  String? address;
  int? defaultPrice;
  String? isActive;
  String? commissionType;
  String? percent;
  int? flat;
  String? holiday;
  String ?ballType;
  int ?ballGiven;
  String? mainImage;
  int? totalAmount;
  String? description;
  List<String>? facility;
  List<BannerImage>? bannerImage;

  GroundDetailData(
      {this.groundId,
        this.categoryId,
        this.vendorId,
        this.title,
        this.openingTime,
        this.closingTime,
        this.address,
        this.defaultPrice,
        this.isActive,
        this.commissionType,
        this.percent,
        this.flat,
        this.holiday,
        this.ballType,
        this.ballGiven,
        this.mainImage,
        this.totalAmount,
        this.description,
        this.facility,
        this.bannerImage});

  GroundDetailData.fromJson(Map<String, dynamic> json) {
    groundId = json['ground_id'];
    categoryId = json['category_id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    address = json['address'].toString();
    defaultPrice = json['default_price'];
    isActive = json['is_active'];
    commissionType = json['commission_type'];
    percent = json['percent'].toString();
    flat = json['flat'];
    holiday = json['holiday'];
    ballType = json['ball_type'];
    ballGiven = json['ball_given'];
    mainImage = json['main_image'];
    totalAmount = json['total_amount'];
    description = json['description'];
    facility = json['facility'].cast<String>();
    if (json['banner_image'] != null) {
      bannerImage = <BannerImage>[];
      json['banner_image'].forEach((v) {
        bannerImage!.add(new BannerImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ground_id'] = this.groundId;
    data['category_id'] = this.categoryId;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['address'] = this.address;
    data['default_price'] = this.defaultPrice;
    data['is_active'] = this.isActive;
    data['commission_type'] = this.commissionType;
    data['percent'] = this.percent;
    data['flat'] = this.flat;
    data['holiday'] = this.holiday;
    data['ball_type'] = this.ballType;
    data['ballGiven'] = this.ballGiven;
    data['main_image'] = this.mainImage;
    data['total_amount'] = this.totalAmount;
    data['description'] = this.description;
    data['facility'] = this.facility;
    if (this.bannerImage != null) {
      data['banner_image'] = this.bannerImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerImage {
  int? imageId;
  String? image;

  BannerImage({this.imageId, this.image});

  BannerImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image'] = this.image;
    return data;
  }
}
