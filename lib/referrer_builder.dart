import 'package:flutter/widgets.dart';
import 'package:flutter_rustore_miniapp_referrer/controller/rustore_miniapp_controller.dart';
import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:lite_state/lite_state.dart';

typedef ReferrerBuilder = Widget Function(ReferrerData? referrerData);

class ReferrerInfoBuilder extends StatefulWidget {
  const ReferrerInfoBuilder({
    super.key,
    required this.builder,
    this.debug = false,
  });

  final ReferrerBuilder builder;

  /// [debug] если передать true, то будет возвращать мок
  /// данные, независимо от того запущено приложение по валидной ссылке или нет
  /// Нужно просто для проверки того, как клиентская часть получает и обрабатывает данные
  final bool debug;

  @override
  State<ReferrerInfoBuilder> createState() => _ReferrerInfoBuilderState();
}

class _ReferrerInfoBuilderState extends State<ReferrerInfoBuilder> {
  @override
  void initState() {
    ruStoreMiniAppController.setDebug(widget.debug);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ReferrerInfoBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.debug != oldWidget.debug) {
      ruStoreMiniAppController.setDebug(widget.debug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiteState<RuStoreMiniAppController>(
      controller: ruStoreMiniAppController,
      builder: (BuildContext c, RuStoreMiniAppController controller) {
        return widget.builder(controller.referrerData);
      },
    );
  }
}
