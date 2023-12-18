
class GettimeslotList {
  bool status;
  String message;
  List<SlotList> data;

  GettimeslotList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GettimeslotList.fromJson(Map<String, dynamic> json) => GettimeslotList(
    status: json["status"],
    message: json["message"],
    data: List<SlotList>.from(json["data"].map((x) => SlotList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SlotList {
  int id;
  int groundId;
  String day;
  String? openingTime;
  String? closingTime;
  int isOffer;
  int? offerPrice;
  DateTime createdAt;
  DateTime updatedAt;

  SlotList({
    required this.id,
    required this.groundId,
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.isOffer,
    required this.offerPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SlotList.fromJson(Map<String, dynamic> json) => SlotList(
    id: json["id"],
    groundId: json["ground_id"],
    day: json["day"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    isOffer: json["is_offer"],
    offerPrice: json["offer_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ground_id": groundId,
    "day": day,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "is_offer": isOffer,
    "offer_price": offerPrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
