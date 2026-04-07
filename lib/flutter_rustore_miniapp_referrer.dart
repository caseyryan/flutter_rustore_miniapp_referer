import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';

import 'flutter_rustore_miniapp_referrer_platform_interface.dart';

class FlutterRustoreMiniappReferrer {
  Future<String?> getPlatformVersion() {
    return FlutterRustoreMiniappReferrerPlatform.instance.getPlatformVersion();
  }

  /// [debug] если передать true, то будет возвращать мок
  /// данные, независимо от того, установлено приложение через RuStore или нет
  /// это не даст понять насколько правильно получена ссылка, но
  /// позволит проверить работает ли плагин вообще.
  /// Если данные вернулись, значит нативная часть доступна и нужный метод в плагине вызывается
  Future<ReferrerData?> getReferrerInfo([bool debug = false]) {
    return FlutterRustoreMiniappReferrerPlatform.instance.getReferrerInfo(
      debug,
    );
  }
}
