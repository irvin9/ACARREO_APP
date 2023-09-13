import 'dart:convert';

class ApiRestPaginated<T> {
  const ApiRestPaginated({
    required this.data,
    required this.links,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory ApiRestPaginated.fromJson(String str, Function transform) =>
      ApiRestPaginated.fromMap(json.decode(str), transform);

  factory ApiRestPaginated.fromMap(
          Map<String, dynamic> json, Function transform) =>
      ApiRestPaginated(
        data: List<T>.from(json["Data"].map((x) => transform(x))),
        links: json["Links"],
        total: json["Total"],
        limit: json["Limit"],
        offset: json["Offset"],
      );

  final List<T> data;
  final int limit;
  final Links links;
  final int offset;
  final int total;

  ApiRestPaginated copyWith(
          {List<T>? data, Links? links, int? total, int? limit, int? offset}) =>
      ApiRestPaginated(
        data: data ?? this.data,
        links: links ?? this.links,
        total: total ?? this.total,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "Data": List<dynamic>.from(data.map((x) => x)),
        "Links": links,
        "Total": total,
        "Limit": limit,
        "Offset": offset,
      };
}

class Links {
  const Links({
    required this.current,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        current: Current.fromJson(json["current"]),
      );

  final Current current;

  Links copyWith({
    Current? current,
  }) =>
      Links(
        current: current ?? this.current,
      );

  Map<String, dynamic> toJson() => {
        "current": current.toJson(),
      };
}

class Current {
  const Current({
    required this.action,
    required this.name,
    required this.ref,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        action: json["Action"],
        name: json["Name"],
        ref: json["Ref"],
      );

  final String action;
  final String name;
  final String ref;

  Current copyWith({
    String? action,
    String? name,
    String? ref,
  }) =>
      Current(
        action: action ?? this.action,
        name: name ?? this.name,
        ref: ref ?? this.ref,
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "Name": name,
        "Ref": ref,
      };
}
