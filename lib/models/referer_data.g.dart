// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefererData _$RefererDataFromJson(Map<String, dynamic> json) => RefererData(
  success: json['success'] as bool?,
  refererId: json['refererId'] as String?,
  error: json['error'] as String?,
  packageName: json['packageName'] as String?,
);

Map<String, dynamic> _$RefererDataToJson(RefererData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'refererId': instance.refererId,
      'error': instance.error,
      'packageName': instance.packageName,
    };
