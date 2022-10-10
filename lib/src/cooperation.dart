import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef CooperationHandler = Future<dynamic> Function(Map? arguments);

class Cooperation {
  Cooperation._() {
    WidgetsFlutterBinding.ensureInitialized();
    _channel.setMethodCallHandler((call) async {
      if (!_handlerMap.containsKey(call.method)) {
        throw MissingPluginException();
      }
      return _handlerMap[call.method]?.call(call.arguments);
    });
  }

  static final _instance = Cooperation._();

  static Cooperation get instance => _instance;

  final _handlerMap = <String, CooperationHandler>{};

  static const _channel = MethodChannel('cooperation_channel');

  addHandler(String method, CooperationHandler handler) {
    _handlerMap[method] = handler;
  }
}
