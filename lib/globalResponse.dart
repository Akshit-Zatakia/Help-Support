import 'dart:convert';

GlobalResponse globalResponseFromJson(String str) => GlobalResponse.fromJson(json.decode(str));

String globalResponseToJson(GlobalResponse data) => json.encode(data.toJson());

class GlobalResponse {
  List<CountriesStat> countriesStat;
  DateTime statisticTakenAt;

  GlobalResponse({
    this.countriesStat,
    this.statisticTakenAt,
  });

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
    countriesStat: List<CountriesStat>.from(json["countries_stat"].map((x) => CountriesStat.fromJson(x))),
    statisticTakenAt: DateTime.parse(json["statistic_taken_at"]),
  );

  Map<String, dynamic> toJson() => {
    "countries_stat": List<dynamic>.from(countriesStat.map((x) => x.toJson())),
    "statistic_taken_at": statisticTakenAt.toIso8601String(),
  };
}

class CountriesStat {
  String countryName;
  String cases;
  String deaths;
  String region;
  String totalRecovered;
  String newDeaths;
  String newCases;
  String seriousCritical;
  String activeCases;
  String totalCasesPer1MPopulation;

  CountriesStat({
    this.countryName,
    this.cases,
    this.deaths,
    this.region,
    this.totalRecovered,
    this.newDeaths,
    this.newCases,
    this.seriousCritical,
    this.activeCases,
    this.totalCasesPer1MPopulation,
  });

  factory CountriesStat.fromJson(Map<String, dynamic> json) => CountriesStat(
    countryName: json["country_name"],
    cases: json["cases"],
    deaths: json["deaths"],
    region: json["region"],
    totalRecovered: json["total_recovered"],
    newDeaths: json["new_deaths"],
    newCases: json["new_cases"],
    seriousCritical: json["serious_critical"],
    activeCases: json["active_cases"],
    totalCasesPer1MPopulation: json["total_cases_per_1m_population"],
  );

  Map<String, dynamic> toJson() => {
    "country_name": countryName,
    "cases": cases,
    "deaths": deaths,
    "region": region,
    "total_recovered": totalRecovered,
    "new_deaths": newDeaths,
    "new_cases": newCases,
    "serious_critical": seriousCritical,
    "active_cases": activeCases,
    "total_cases_per_1m_population": totalCasesPer1MPopulation,
  };
}
