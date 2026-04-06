import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_rustore_miniapp_referer_platform_interface.dart';

class FlutterRustoreMiniappRefererWeb extends FlutterRustoreMiniappRefererPlatform {
  FlutterRustoreMiniappRefererWeb();

  static void registerWith(Registrar registrar) {
    FlutterRustoreMiniappRefererPlatform.instance = FlutterRustoreMiniappRefererWeb();
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
  Future<RefererData?> getRefererInfo([bool debug = false]) async {
    if (debug) {
      return RefererData(refererId: 'test_web_referer_123', packageName: 'com.softmaestri.flutter_rustore_miniapp_referer', success: true);
    }
    final String currentHref = web.window.location.href;
    final uri = Uri.parse(currentHref);
    
    // Вытаскиваем конкретный параметр, например 'referer' или 'utm_source'
    final String? refererId = uri.queryParameters['refererId'] ?? uri.queryParameters['utm_source'];

    return RefererData(refererId: refererId ?? '', packageName: '', success: true);
  }
}
