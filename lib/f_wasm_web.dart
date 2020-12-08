import 'dart:async';
import 'dart:html' as html;
import 'package:f_wasm/web/m.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class FWasmWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel('f_wasm', const StandardMethodCodec(), registrar.messenger);
    final pluginInstance = FWasmWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'version':
        return version();
      default:
        throw PlatformException(code: 'Unimplemented', details: 'f_wasm for web doesn\'t implement \'${call.method}\'');
    }
  }

  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }

  Future<String> version() {
    // html.window.html["Module"].callMethod('_version').toString();
    // String v = loader.callfunc('version', []) as String;
    int v = Module.add(1, 5);
    // String v = "_version()";
    return Future.value("$v");
  }
}
