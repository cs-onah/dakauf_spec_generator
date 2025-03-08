import 'package:dakauf_spec_generator/core/models/attribute.dart';

class SectionData {
  String? name;
  List<Attribute> attributes;

  SectionData({
    this.name,
    this.attributes = const [],
  });

  SectionData copyWith({
    String? name,
    List<Attribute>? attributes,
  }) =>
      SectionData(
        name: name ?? this.name,
        attributes: attributes ?? this.attributes,
      );

  factory SectionData.fromJson(Map<String, dynamic> json) => SectionData(
        name: json["name"],
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}
