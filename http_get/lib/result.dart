import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  int count;
  String next;
  String previous;
  List<Item> results;

  Result(this.count, this.next, this.previous, this.results);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Item {
  String name;
  String height;
  String mass;
  String hair_color;
  String skin_color;
  String eye_color;
  String birth_year;
  String gender;
  String homewold;
  List<String> films;
  List<String> species;
  List<String> vehicles;
  List<String> starships;
  String created;
  String edited;
  String url;

  Item(this.name, this.height, this.mass, this.hair_color, this.skin_color,
      this.eye_color, this.birth_year, this.gender, this.homewold, this.films,
      this.species, this.vehicles, this.starships, this.created, this.edited,
      this.url);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}