import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_rustore_miniapp_referrer_method_channel.dart';

abstract class FlutterRustoreMiniappReferrerPlatform extends PlatformInterface {
  FlutterRustoreMiniappReferrerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRustoreMiniappReferrerPlatform _instance = MethodChannelFlutterRustoreMiniappReferrer();
  static FlutterRustoreMiniappReferrerPlatform get instance => _instance;

  static set instance(FlutterRustoreMiniappReferrerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<ReferrerData?> getReferrerInfo([bool debug = false]) {
    throw UnimplementedError('getReferrerInfo() has not been implemented.');
  }
}
