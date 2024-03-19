import 'package:flutter/material.dart';

class DeviceSize {
  static final deviceWidth = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.single)
      .size
      .width;
  static final deviceHeight = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.single)
      .size
      .height;
}
