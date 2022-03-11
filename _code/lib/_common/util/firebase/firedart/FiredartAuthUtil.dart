class FiredartAuthUtil {
  static bool _haveEverInit = false;

  static Future<void> init() async {
    if (!_haveEverInit) {
      _haveEverInit = true;


    }
  }

}