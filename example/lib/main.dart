import 'package:flutter/material.dart';
import 'package:flutter_rustore_miniapp_referrer/models/referrer_data.dart';
import 'package:flutter_rustore_miniapp_referrer/referrer_builder.dart';

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
        body: ReferrerInfoBuilder(
          debug: _isDebug,
          builder: (ReferrerData? referrerData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    '$_title referrerData: $referrerData',
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
