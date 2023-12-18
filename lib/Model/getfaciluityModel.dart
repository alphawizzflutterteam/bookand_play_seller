


class GetFacility {
  bool status;
  String message;
  List<Datum> data;

  GetFacility({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetFacility.fromJson(Map<String, dynamic> json) => GetFacility(
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
  String title;

  Datum({
    required this.id,
    required this.title,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
