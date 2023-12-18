
class FaqModel {
  bool status;
  String message;
  List<FaqList> data;

  FaqModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    status: json["status"],
    message: json["message"],
    data: List<FaqList>.from(json["data"].map((x) => FaqList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FaqList {
  int id;
  String title;
  String description;
  DateTime? createdAt;
  dynamic updatedAt;

  FaqList({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}
