import 'dart:convert';

IndiaResponse indiaResponseFromJson(String str) => IndiaResponse.fromJson(json.decode(str));

String indiaResponseToJson(IndiaResponse data) => json.encode(data.toJson());

class IndiaResponse {
  bool success;
  Data data;
  DateTime lastRefreshed;
  DateTime lastOriginUpdate;

  IndiaResponse({
    this.success,
    this.data,
    this.lastRefreshed,
    this.lastOriginUpdate,
  });

  factory IndiaResponse.fromJson(Map<String, dynamic> json) => IndiaResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    lastRefreshed: DateTime.parse(json["lastRefreshed"]),
    lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "lastRefreshed": lastRefreshed.toIso8601String(),
    "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
  };
}

class Data {
  String source;
  DateTime lastRefreshed;
  Total total;
  List<Total> statewise;

  Data({
    this.source,
    this.lastRefreshed,
    this.total,
    this.statewise,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    source: json["source"],
    lastRefreshed: DateTime.parse(json["lastRefreshed"]),
    total: Total.fromJson(json["total"]),
    statewise: List<Total>.from(json["statewise"].map((x) => Total.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "lastRefreshed": lastRefreshed.toIso8601String(),
    "total": total.toJson(),
    "statewise": List<dynamic>.from(statewise.map((x) => x.toJson())),
  };
}

class Total {
  String state;
  int confirmed;
  int recovered;
  int deaths;
  int active;

  Total({
    this.state,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.active,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    state: json["state"] == null ? null : json["state"],
    confirmed: json["confirmed"],
    recovered: json["recovered"],
    deaths: json["deaths"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "state": state == null ? null : state,
    "confirmed": confirmed,
    "recovered": recovered,
    "deaths": deaths,
    "active": active,
  };
}