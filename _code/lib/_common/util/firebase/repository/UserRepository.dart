import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class User extends WithDocId {
  String? email;
  List? allowedUidList;

  User({required this.email, required this.allowedUidList}) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  User.empty();

  factory User.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static User fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      allowedUidList: map['allowedUidList'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(User instance) {
    return {
      'documentId': instance.documentId,
      'email': instance.email,
      'allowedUidList': instance.allowedUidList,
    };
  }
}

class UserRepository {
  static final UserRepository _singleton =
      UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  final FirebaseStoreUtilInterface<User> _ =
      FirebaseStoreUtilInterface.init<User>(
    collectionName: StringUtil.classToString(User.empty()),
    fromMap: User.fromMap,
    toMap: User.toMap,
  );

  Future<void> addAllowedUid({required String email, required String uid}) async {
    User? user =  await _.getOneByField(key: "email", value: email);
    if(user?.allowedUidList == null) {
      await _.saveByDocumentId(instance: User(email: email, allowedUidList: [uid]));
      return;
    }

    User tempUser = user!;
    var allowedUidList = tempUser.allowedUidList!;
    if(!allowedUidList.contains(uid)) {
      allowedUidList.add(uid);
    }

    await _.saveByDocumentId(instance: tempUser);
  }

  Future<void> removeAllowedUid({required String email, required String uid}) async {
    User? user =  await _.getOneByField(key: "email", value: email);
    if(user == null) {
      LogUtil.error("해당 email의 유저가 없어 삭제할 수 없습니다");
      return;
    }

    var allowedUidList = user.allowedUidList!;
    if(allowedUidList.contains(uid)) {
      allowedUidList.remove(uid);
    }

    await _.saveByDocumentId(instance: user);
  }
}
