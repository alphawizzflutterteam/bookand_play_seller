class TimeslotModel {
  bool? status;
  String? message;
  TimeSlotData? data;

  TimeslotModel({this.status, this.message, this.data});

  TimeslotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new TimeSlotData.fromJson(json['data']) : null;
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

class TimeSlotData {
  String? groundId;
  String? date;
  List<Slots>? slots;

  TimeSlotData({this.groundId, this.date, this.slots});

  TimeSlotData.fromJson(Map<String, dynamic> json) {
    groundId = json['ground_id'];
    date = json['date'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ground_id'] = this.groundId;
    data['date'] = this.date;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  String? fromTime;
  String? toTime;
  int? isBooked;
  int? isOffer;
  int? price;

  Slots({this.fromTime, this.toTime, this.isBooked, this.isOffer, this.price});

  Slots.fromJson(Map<String, dynamic> json) {
    fromTime = json['from_time'];
    toTime = json['to_time'];
    isBooked = json['is_booked'];
    isOffer = json['is_offer'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['is_booked'] = this.isBooked;
    data['is_offer'] = this.isOffer;
    data['price'] = this.price;
    return data;
  }
}
