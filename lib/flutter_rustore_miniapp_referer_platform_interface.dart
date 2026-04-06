import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_rustore_miniapp_referer_method_channel.dart';

abstract class FlutterRustoreMiniappRefererPlatform extends PlatformInterface {
  FlutterRustoreMiniappRefererPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRustoreMiniappRefererPlatform _instance = MethodChannelFlutterRustoreMiniappReferer();
  static FlutterRustoreMiniappRefererPlatform get instance => _instance;

  static set instance(FlutterRustoreMiniappRefererPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<RefererData?> getRefererInfo([bool debug = false]) {
    throw UnimplementedError('getRefererInfo() has not been implemented.');
  }
}
