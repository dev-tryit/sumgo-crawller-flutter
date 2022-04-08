


class StringUtil {
  static String classToString(Type clazz) {
    String returnStr = "";
    returnStr = clazz.toString();
    returnStr = returnStr.replaceAll(r"$", "");
    return returnStr;
  }

  static bool isEmpty(String str) {
    return str.isEmpty;
  }

  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }
}