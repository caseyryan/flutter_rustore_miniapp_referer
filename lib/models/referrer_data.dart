// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:lite_state/lite_state.dart';


part 'referrer_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ReferrerData implements LSJsonEncodable {
  ReferrerData({
    this.success,
    this.referrerId,
    this.error,
    this.packageName,
  });

  bool? success;
  String? referrerId;
  String? error;
  String? packageName;

  static ReferrerData deserialize(Map<String, dynamic> json) {
    return ReferrerData.fromJson(json);
  }

  factory ReferrerData.fromJson(Map<String, dynamic> json) {
      return _$ReferrerDataFromJson(json);
    }
  
  Map<String, dynamic> toJson() {
    return _$ReferrerDataToJson(this);
  }

  @override
  String toString() {
    return JsonEncoder.withIndent('  ').convert(toJson());
  }

  static ReferrerData decode(Map data) {
    return ReferrerData.fromJson(data.cast());
  }

  @override
  Map<dynamic, dynamic> encode() {
    return toJson();
  }
}
