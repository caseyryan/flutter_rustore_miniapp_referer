// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referrer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferrerData _$ReferrerDataFromJson(Map<String, dynamic> json) => ReferrerData(
  success: json['success'] as bool?,
  referrerId: json['referrerId'] as String?,
  error: json['error'] as String?,
  packageName: json['packageName'] as String?,
);

Map<String, dynamic> _$ReferrerDataToJson(ReferrerData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'referrerId': instance.referrerId,
      'error': instance.error,
      'packageName': instance.packageName,
    };
