// To parse this JSON data, do
//
//     final placesModel = placesModelFromJson(jsonString);

import 'dart:convert';

  List<PlacesModel> placesModelFromJson(String str) =>List<PlacesModel>.from(
    json.decode(str).map((x) => PlacesModel.fromJson(x)));

    String placesModelToJson(List<PlacesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlacesModel {
  List<Datum> data;
  Links links;
  Meta meta;

  PlacesModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class Datum {
  int id;
  String placeName;
  String placePhoto;
  String placeDescription;
  String placeLocation;
  String openTime;
  String createdAt;

  Datum({
    required this.id,
    required this.placeName,
    required this.placePhoto,
    required this.placeDescription,
    required this.placeLocation,
    required this.openTime,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    placeName: json["place_name"],
    placePhoto: json["place_photo"],
    placeDescription: json["place_description"],
    placeLocation: json["place_location"],
    openTime: json["open_time"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "place_name": placeName,
    "place_photo": placePhoto,
    "place_description": placeDescription,
    "place_location": placeLocation,
    "open_time": openTime,
    "created_at": createdAt,
  };
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
