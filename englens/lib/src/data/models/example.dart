import 'package:englens/src/core/configs/hive/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'generated/example.g.dart';

@HiveType(typeId: HiveTypes.example)
class Example {
  @HiveField(0)
  String cf;

  @HiveField(1)
  String x;

  Example({required this.cf, required this.x});

  factory Example.fromMap(Map<String, dynamic> json) {
    return Example(cf: json["cf"], x: json["x"]);
  }

  Map<String, dynamic> toMap() {
    return {"cf": cf, "x": x};
  }
}
