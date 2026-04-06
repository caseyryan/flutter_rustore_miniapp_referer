import 'package:flutter_rustore_miniapp_referer/flutter_rustore_miniapp_referer.dart';
import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';
import 'package:lite_state/lite_state.dart';

RuStoreMiniAppController? _ruStoreMiniAppController;

RuStoreMiniAppController get ruStoreMiniAppController {
  if (_ruStoreMiniAppController == null) {
    _ruStoreMiniAppController = RuStoreMiniAppController();
    initJsonDecoders({
      RefererData: (data) => RefererData.decode(data),
    });
  }
  return _ruStoreMiniAppController!;
}

class RuStoreMiniAppController extends LiteStateController<RuStoreMiniAppController> {
  RuStoreMiniAppController() : super(preserveLocalStorageOnControllerDispose: true, useLocalStorage: true);

  static const _debugKey = 'debugReferer';
  static const _prodKey = 'prodReferer';

  RefererData? _refererData;
  RefererData? get refererData => _refererData;

  bool _isDebug = false;

  void setDebug(bool value) {
    _isDebug = value;
  }

  @override
  void reset() {}

  Future loadRefererData([bool debug = false]) async {
    if (!isLocalStorageInitialized) {
      return;
    }
    if (debug) {
      _refererData = await getPersistentValue<RefererData>(_debugKey);
      if (_refererData != null) {
        rebuild();
        return;
      }
    } else {
      _refererData = await getPersistentValue<RefererData>(_prodKey);
      if (_refererData != null) {
        rebuild();
        return;
      }
    }
    _refererData = await FlutterRustoreMiniappReferer().getRefererInfo(debug);
    if (_refererData?.success == true && _refererData?.refererId?.isNotEmpty == true) {
      if (debug) {
        await setPersistentValue<RefererData>(_debugKey, _refererData!);
      } else {
        await setPersistentValue<RefererData>(_prodKey, _refererData!);
      }
    }
    rebuild();
  }

  @override
  void onLocalStorageInitialized() {
    loadRefererData(_isDebug);
  }
}
