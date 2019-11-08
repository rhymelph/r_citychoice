class Province {
  String code;
  String name;
  List<City> childs;

  Province(this.code, this.name, this.childs);

  factory Province.formMap(Map map) => Province(map['code'], map['name'],
      (map['childs'] as List).map((item) => City.formMap(item)).toList());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Province &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name &&
          childs == other.childs;

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ childs.hashCode;
}

class City {
  String code;
  String name;
  List<Area> childs;

  City(this.code, this.name, this.childs);

  factory City.formMap(Map map) => City(map['code'], map['name'],
      map['childs']==null?null:(map['childs'] as List).map((item) => Area.formMap(item)).toList());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name &&
          childs == other.childs;

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ childs.hashCode;
}

class Area {
  String code;
  String name;
  List<Street> childs;

  Area(this.code, this.name, this.childs);

  factory Area.formMap(Map map) => Area(
      map['code'],
      map['name'],
      map['childs'] == null
          ? null
          : (map['childs'] as List)
              .map((item) => Street.formMap(item))
              .toList());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Area &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name &&
          childs == other.childs;

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ childs.hashCode;
}

class Street {
  final String code;
  final String name;

  Street(this.code, this.name);

  factory Street.formMap(Map map) => Street(map['code'], map['name']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Street &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name;

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}

class SelectStreetResult {
  final Province province;
  final City city;
  final Area area;
  final Street street;

  SelectStreetResult(this.province, this.city, this.area, this.street);

  @override
  String toString() {
    return '${province.name}${city.name}${area.name}${street.name}';
  }
}

class SelectAreaResult {
  final Province province;
  final City city;
  final Area area;

  SelectAreaResult(
    this.province,
    this.city,
    this.area,
  );

  @override
  String toString() {
    return '${province.name}${city.name}${area.name}';
  }
}

class SelectCityResult {
  final Province province;
  final City city;

  SelectCityResult(
      this.province,
      this.city,
      );

  @override
  String toString() {
    return '${province.name}${city.name}';
  }
}

