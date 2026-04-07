import 'package:flutter/material.dart';
import 'package:flutter_rustore_miniapp_referer/models/referer_data.dart';

import 'package:flutter_rustore_miniapp_referer/referer_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isDebug = true;

  @override
  void initState() {
    super.initState();
  }

  String get _title {
    return _isDebug ? 'Debug' : 'Release';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: RefererInfoBuilder(
          debug: _isDebug,
          builder: (RefererData? refererData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity,),
                  Text(
                    '$_title refererData: $refererData',
                  ),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _isDebug = true;
                      });
                    },
                    child: Text(
                      'Debug Данные',
                    ),
                  ),
                  MaterialButton(
                    color: Colors.amber,
                    onPressed: () {
                      setState(() {
                        _isDebug = false;
                      });
                    },
                    child: Text(
                      'Реальные Данные',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
