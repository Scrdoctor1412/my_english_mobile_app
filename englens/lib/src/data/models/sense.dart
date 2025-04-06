import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/example.dart';
import 'package:hive_flutter/adapters.dart';

part 'generated/sense.g.dart';

@HiveType(typeId: HiveTypes.sense)
class Sense {
  @HiveField(0)
  String definition;

  @HiveField(1)
  List<Example>? examples;

  Sense({
    required this.definition,
    this.examples,
  });

  factory Sense.fromMap(Map<String, dynamic> json) {
    return Sense(
      definition: json["definition"],
      examples:
          (json["examples"] as List).map((e) => Example.fromMap(e)).toList(),
      // examples: json["examples"] != null
      //     ? (json["examples"] as List).map((e) => Example.fromMap(e)).toList()
      //     : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "definition": definition,
      "examples": examples?.map((e) => e.toMap()).toList(),
    };
  }
}
