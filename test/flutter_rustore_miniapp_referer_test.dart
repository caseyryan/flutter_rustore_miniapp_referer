import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rustore_miniapp_referrer/flutter_rustore_miniapp_referrer.dart';
import 'package:flutter_rustore_miniapp_referrer/flutter_rustore_miniapp_referrer_platform_interface.dart';
import 'package:flutter_rustore_miniapp_referrer/flutter_rustore_miniapp_referrer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterRustoreMiniappReferrerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterRustoreMiniappReferrerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<ReferrerData?> getReferrerInfo([bool debug = false]) {
    return Future.value(
      ReferrerData(
        success: true,
        referrerId: "123",
        packageName: "com.softmaestri.flutter_rustore_miniapp_referrer",
      ),
    );
  }
}

void main() {
  final FlutterRustoreMiniappReferrerPlatform initialPlatform =
      FlutterRustoreMiniappReferrerPlatform.instance;

  test(
    '$MethodChannelFlutterRustoreMiniappReferrer is the default instance',
    () {
      expect(
        initialPlatform,
        isInstanceOf<MethodChannelFlutterRustoreMiniappReferrer>(),
      );
    },
  );

  test('getPlatformVersion', () async {
    FlutterRustoreMiniappReferrer flutterRustoreMiniappReferrerPlugin =
        FlutterRustoreMiniappReferrer();
    MockFlutterRustoreMiniappReferrerPlatform fakePlatform =
        MockFlutterRustoreMiniappReferrerPlatform();
    FlutterRustoreMiniappReferrerPlatform.instance = fakePlatform;

    expect(
      await flutterRustoreMiniappReferrerPlugin.getPlatformVersion(),
      '42',
    );
  });
}
