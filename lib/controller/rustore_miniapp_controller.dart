import 'package:flutter_rustore_miniapp_referrer/flutter_rustore_miniapp_referrer.dart';
import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:lite_state/lite_state.dart';

RuStoreMiniAppController? _ruStoreMiniAppController;

RuStoreMiniAppController get ruStoreMiniAppController {
  if (_ruStoreMiniAppController == null) {
    _ruStoreMiniAppController = RuStoreMiniAppController();
    initJsonDecoders({
      ReferrerData: (data) => ReferrerData.decode(data),
    });
  }
  return _ruStoreMiniAppController!;
}

class RuStoreMiniAppController
    extends LiteStateController<RuStoreMiniAppController> {
  RuStoreMiniAppController()
    : super(
        preserveLocalStorageOnControllerDispose: true,
        useLocalStorage: true,
      );

  static const _debugKey = 'debugReferrerKey';
  static const _prodKey = 'prodReferrerKey';

  ReferrerData? _referrerData;
  ReferrerData? get referrerData => _referrerData;

  bool _isDebug = false;

  void setDebug(bool value) {
    if (_isDebug != value) {
      _referrerData = null;
    }
    _isDebug = value;
    loadReferrerData(_isDebug);
  }

  @override
  void reset() {}

  Future loadReferrerData([bool debug = false]) async {
    if (!isLocalStorageInitialized) {
      return;
    }
    if (debug) {
      _referrerData = await getPersistentValue<ReferrerData>(_debugKey);
      if (_referrerData != null) {
        rebuild();
        return;
      }
    } else {
      _referrerData = await getPersistentValue<ReferrerData>(_prodKey);
      if (_referrerData != null) {
        rebuild();
        return;
      }
    }
    _referrerData = await FlutterRustoreMiniappReferrer().getReferrerInfo(
      debug,
    );
    if (_referrerData?.success == true &&
        _referrerData?.referrerId?.isNotEmpty == true) {
      if (debug) {
        await setPersistentValue<ReferrerData>(_debugKey, _referrerData!);
      } else {
        await setPersistentValue<ReferrerData>(_prodKey, _referrerData!);
      }
    }
    rebuild();
  }

  @override
  void onLocalStorageInitialized() {
    loadReferrerData(_isDebug);
  }
}
