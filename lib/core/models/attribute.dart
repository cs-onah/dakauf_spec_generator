class Attribute {
  String? name;
  String? value;

  Attribute({
    this.name,
    this.value,
  });

  Attribute copyWith({
    String? name,
    String? value,
  }) =>
      Attribute(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}