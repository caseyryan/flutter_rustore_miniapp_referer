import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';

import 'flutter_rustore_miniapp_referrer_platform_interface.dart';

/// An implementation of [FlutterRustoreMiniappReferrerPlatform] that uses method channels.
class MethodChannelFlutterRustoreMiniappReferrer extends FlutterRustoreMiniappReferrerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_rustore_miniapp_referrer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<ReferrerData?> getReferrerInfo([bool debug = false]) async {
    final result = await methodChannel.invokeMethod<dynamic>(
      'getReferrerInfo',
      {
        'debug': debug,
      },
    );
    if (result == null) return null;
    return ReferrerData.fromJson(jsonDecode(result));
  }
}
