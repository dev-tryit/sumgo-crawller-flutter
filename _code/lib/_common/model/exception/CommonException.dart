class CommonException implements Exception {
  String message;

  CommonException(this.message);

  @override
  String toString() => message;
}
