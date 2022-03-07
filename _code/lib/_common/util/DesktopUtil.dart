import 'dart:ui';

import 'package:window_manager/window_manager.dart';

class DesktopUtil {
  static Future setSize(
      {required Size size, Size? minimumSize, Size? maximumSize}) async {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      // Hide window title bar
      // await windowManager.setTitleBarStyle('hidden');
      await windowManager.setSize(size);
      if (minimumSize != null) {
        await windowManager.setMinimumSize(minimumSize);
      }
      if (maximumSize != null) {
        await windowManager.setMaximumSize(maximumSize);
        await windowManager.setFullScreen(false);
      }
      // await windowManager.center();
      await windowManager.show();
      // await windowManager.setSkipTaskbar(false);
    });
  }
//
// static Future setMaxSize(Size size) async {
//   return await DesktopWindow.setMaxWindowSize(size);
// }
//
// static Future setMinSize(Size size) async {
//   return await DesktopWindow.setMinWindowSize(size);
// }
//
// static Future<Size> getSize() async {
//   return await DesktopWindow.getWindowSize();
// }
//
// static Future<bool> isFullScreen() async {
//   return await DesktopWindow.getFullScreen();
// }
//
// static Future resetMaxWindowSize() async {
//   return await DesktopWindow.resetMaxWindowSize();
// }
//
// static Future toggleFullScreen() async {
//   return await DesktopWindow.toggleFullScreen();
// }
//
// static Future setFullScreen(bool fullscreen) async {
//   return await DesktopWindow.setFullScreen(fullscreen);
// }
}
