import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class User {
  List<Data> list;

  User(this.list);

  factory User.fromJson(List<dynamic> json) {
   List<Data> dataList = new List();
   dataList = json.map((i) => Data.fromJson(i)).toList();
   return new User(dataList);
  }

  List<dynamic> toJson() {
    List<dynamic> datalist = new List();
    datalist = list.map((i) => i.toJson()).toList();
    return datalist;
  }
}

@JsonSerializable()
class Data {

  String name;
  String height;
  String mass;
  String hair_color;
  String skin_color;
  String eye_color;
  String birth_year;
  String gender;

  Data(this.name, this.height, this.mass, this.hair_color,
      this.skin_color, this.eye_color, this.birth_year, this.gender);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

