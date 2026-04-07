import 'package:flutter/widgets.dart';
import 'package:flutter_rustore_miniapp_referer/controller/rustore_miniapp_controller.dart';
import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';
import 'package:lite_state/lite_state.dart';

typedef RefererBuilder = Widget Function(RefererData? refererData);


class RefererInfoBuilder extends StatefulWidget {
  const RefererInfoBuilder({super.key, required this.builder, this.debug = false});

  final RefererBuilder builder;
  /// [debug] если передать true, то будет возвращать мок 
  /// данные, независимо от того запущено приложение по валидной ссылке или нет
  /// Нужно просто для проверки того, как клиентская часть получает и обрабатывает данные
  final bool debug;

  @override
  State<RefererInfoBuilder> createState() => _RefererInfoBuilderState();
}

class _RefererInfoBuilderState extends State<RefererInfoBuilder> {

  @override
  void initState() {
    ruStoreMiniAppController.setDebug(widget.debug);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RefererInfoBuilder oldWidget) {
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
        return widget.builder(controller.refererData);
      },
    );
  }
}
