import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';

class DesktopUtil {
  static Future setSize(Size size) async {
    return await DesktopWindow.setWindowSize(size);
  }

  static Future setMaxSize(Size size) async {
    return await DesktopWindow.setMaxWindowSize(size);
  }

  static Future setMinSize(Size size) async {
    return await DesktopWindow.setMinWindowSize(size);
  }

  static Future<Size> getSize() async {
    return await DesktopWindow.getWindowSize();
  }

  static Future<bool> isFullScreen() async {
    return await DesktopWindow.getFullScreen();
  }

  static Future resetMaxWindowSize() async {
    return await DesktopWindow.resetMaxWindowSize();
  }

  static Future toggleFullScreen() async {
    return await DesktopWindow.toggleFullScreen();
  }

  static Future setFullScreen(bool fullscreen) async {
    return await DesktopWindow.setFullScreen(fullscreen);
  }
}
