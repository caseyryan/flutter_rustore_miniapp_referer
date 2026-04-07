import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_rustore_miniapp_referrer_platform_interface.dart';

class FlutterRustoreMiniappReferrerWeb extends FlutterRustoreMiniappReferrerPlatform {
  FlutterRustoreMiniappReferrerWeb();

  static void registerWith(Registrar registrar) {
    FlutterRustoreMiniappReferrerPlatform.instance = FlutterRustoreMiniappReferrerWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }

  /// [debug] если передать true, то будет возвращать мок 
  /// данные, независимо от того запущено приложение по валидной ссылке или нет
  /// Нужно просто для проверки того, как клиентская часть получает и обрабатывает данные
  @override
  Future<ReferrerData?> getReferrerInfo([bool debug = false]) async {
    if (debug) {
      return ReferrerData(referrerId: 'test_web_referrer_123', packageName: 'com.softmaestri.flutter_rustore_miniapp_referrer', success: true);
    }
    final String currentHref = web.window.location.href;
    final uri = Uri.parse(currentHref);
    
    // Вытаскиваем конкретный параметр, например 'referrer' или 'utm_source'
    final String? referrerId = uri.queryParameters['referrerId'] ?? uri.queryParameters['utm_source'];

    return ReferrerData(referrerId: referrerId ?? '', packageName: '', success: true);
  }
}
