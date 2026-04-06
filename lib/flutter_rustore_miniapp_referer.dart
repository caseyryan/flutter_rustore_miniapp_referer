
import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';

import 'flutter_rustore_miniapp_referer_platform_interface.dart';

class FlutterRustoreMiniappReferer {
  Future<String?> getPlatformVersion() {
    return FlutterRustoreMiniappRefererPlatform.instance.getPlatformVersion();
  }

  /// [debug] если передать true, то будет возвращать мок 
  /// данные, независимо от того, установлено приложение через RuStore или нет
  /// это не даст понять насколько правильно получена ссылка, но 
  /// позволит проверить работает ли плагин вообще.
  /// Если данные вернулись, значит нативная часть доступна и нужный метод в плагине вызывается 
  Future<RefererData?> getRefererInfo([bool debug = false]) {
    return FlutterRustoreMiniappRefererPlatform.instance.getRefererInfo(debug);
  }
}
