import 'package:flutter/material.dart';

class DeviceCharacteristics {
  static double width;
  static double height;

  static void init() {
    MediaQueryData mqd =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    width = mqd.size.width;
    height = mqd.size.height;
  }
}
