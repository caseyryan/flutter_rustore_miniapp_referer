import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';

import 'flutter_rustore_miniapp_referer_platform_interface.dart';

/// An implementation of [FlutterRustoreMiniappRefererPlatform] that uses method channels.
class MethodChannelFlutterRustoreMiniappReferer extends FlutterRustoreMiniappRefererPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_rustore_miniapp_referer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<RefererData?> getRefererInfo([bool debug = false]) async {
    final result = await methodChannel.invokeMethod<String>('getRefererInfo', {'debug': debug});
    if (result == null) return null;
    return RefererData.fromJson(jsonDecode(result));
  }
}
