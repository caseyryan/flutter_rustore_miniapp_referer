// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:lite_state/lite_state.dart';


part 'referer_data.g.dart';

@JsonSerializable(explicitToJson: true)
class RefererData implements LSJsonEncodable {
  RefererData({
    this.success,
    this.refererId,
    this.error,
    this.packageName,
  });

  bool? success;
  String? refererId;
  String? error;
  String? packageName;

  static RefererData deserialize(Map<String, dynamic> json) {
    return RefererData.fromJson(json);
  }

  factory RefererData.fromJson(Map<String, dynamic> json) {
      return _$RefererDataFromJson(json);
    }
  
  Map<String, dynamic> toJson() {
    return _$RefererDataToJson(this);
  }

  @override
  String toString() {
    return JsonEncoder.withIndent('  ').convert(toJson());
  }

  static RefererData decode(Map data) {
    return RefererData.fromJson(data.cast());
  }

  @override
  Map<dynamic, dynamic> encode() {
    return toJson();
  }
}
