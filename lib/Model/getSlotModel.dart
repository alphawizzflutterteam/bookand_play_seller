
class TimeslotModel {
  bool status;
  String message;
  Data data;

  TimeslotModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) => TimeslotModel(
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
  String groundId;
  DateTime date;
  List<Slot> slots;

  Data({
    required this.groundId,
    required this.date,
    required this.slots,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    groundId: json["ground_id"],
    date: DateTime.parse(json["date"]),
    slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ground_id": groundId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  String time;
  int isBooked;
  int isOffer;
  int price;

  Slot({
    required this.time,
    required this.isBooked,
    required this.isOffer,
    required this.price,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    time: json["time"],
    isBooked: json["is_booked"],
    isOffer: json["is_offer"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "is_booked": isBooked,
    "is_offer": isOffer,
    "price": price,
  };
}
