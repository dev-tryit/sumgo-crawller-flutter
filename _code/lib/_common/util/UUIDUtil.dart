import 'package:uuid/uuid.dart';

class UUIDUtil {
  static Uuid uuid = Uuid();

  static String makeUuid(
      {bool isRandomBased = true, bool isTimeSpaceBased = false}) {
    return (isRandomBased ? uuid.v4() : uuid.v1());
  }
}
