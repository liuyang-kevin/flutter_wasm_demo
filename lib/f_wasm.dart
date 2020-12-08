import 'dart:async';

import 'package:flutter/services.dart';

class FWasm {
  static const MethodChannel _channel = const MethodChannel('f_wasm');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get version async {
    final String version = await _channel.invokeMethod('version');
    return version;
  }
}
