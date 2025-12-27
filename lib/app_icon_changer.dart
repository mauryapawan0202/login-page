import 'package:flutter/services.dart';

class AppIconChanger {
  static const MethodChannel _channel = MethodChannel('icon_channel');

  static Future<void> change(String iconName) async {
    await _channel.invokeMethod('changeIcon', iconName);
  }
}