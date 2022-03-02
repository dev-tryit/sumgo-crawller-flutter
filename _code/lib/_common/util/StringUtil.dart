class StringUtil {
  static String classToString(dynamic clazz) {
    String returnStr = "";
    returnStr = clazz.runtimeType.toString();
    returnStr = returnStr.replaceAll(r"$", "");
    return returnStr;
  }

  static isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }
}
