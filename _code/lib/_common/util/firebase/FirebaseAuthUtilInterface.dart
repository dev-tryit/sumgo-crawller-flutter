abstract class FirebaseAuthUtilInterface {
  bool _haveEverInit = false;

  Future<void> init();
}