import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rustore_miniapp_referer/flutter_rustore_miniapp_referer.dart';
import 'package:flutter_rustore_miniapp_referer/flutter_rustore_miniapp_referer_platform_interface.dart';
import 'package:flutter_rustore_miniapp_referer/flutter_rustore_miniapp_referer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterRustoreMiniappRefererPlatform
    with MockPlatformInterfaceMixin
    implements FlutterRustoreMiniappRefererPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<RefererData?> getRefererInfo([bool debug = false]) {
    return Future.value(
      RefererData(success: true, refererId: "123", packageName: "com.softmaestri.flutter_rustore_miniapp_referer"),
    );
  }
}

void main() {
  final FlutterRustoreMiniappRefererPlatform initialPlatform = FlutterRustoreMiniappRefererPlatform.instance;

  test('$MethodChannelFlutterRustoreMiniappReferer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterRustoreMiniappReferer>());
  });

  test('getPlatformVersion', () async {
    FlutterRustoreMiniappReferer flutterRustoreMiniappRefererPlugin = FlutterRustoreMiniappReferer();
    MockFlutterRustoreMiniappRefererPlatform fakePlatform = MockFlutterRustoreMiniappRefererPlatform();
    FlutterRustoreMiniappRefererPlatform.instance = fakePlatform;

    expect(await flutterRustoreMiniappRefererPlugin.getPlatformVersion(), '42');
  });
}
