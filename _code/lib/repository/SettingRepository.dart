import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
import 'package:sumgo_crawller_flutter/widget/SelectRemovalType.dart';

class Setting extends WithDocId {
  String? sumgoId;
  String? sumgoPw;
  String? crallwerUrl;

  Setting(
      {required this.sumgoId, required this.sumgoPw, required this.crallwerUrl})
      : super(documentId: DateTime.now().microsecondsSinceEpoch);

  Setting.empty(): super(documentId: DateTime.now().microsecondsSinceEpoch);

  factory Setting.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static Setting fromMap(Map<String, dynamic> map) {
    return Setting(
      sumgoId: map['sumgoId'],
      sumgoPw: map['sumgoPw'],
      crallwerUrl: map['crallwerUrl'],
    )
      ..documentId = map['documentId']
      ..email = map['email'];
  }

  static Map<String, dynamic> toMap(Setting instance) {
    return {
      'documentId': instance.documentId,
      'email': instance.email,
      'sumgoId': instance.sumgoId,
      'sumgoPw': instance.sumgoPw,
      'crallwerUrl': instance.crallwerUrl,
    };
  }
}

class SettingRepository {
  static final SettingRepository _singleton = SettingRepository._internal();

  factory SettingRepository() {
    return _singleton;
  }

  SettingRepository._internal();

  final FirebaseStoreUtilInterface<Setting> _ =
      FirebaseStoreUtilInterface.init<Setting>(
    collectionName: StringUtil.classToString(Setting.empty()),
    fromMap: Setting.fromMap,
    toMap: Setting.toMap,
  );

  Future<Setting?> save({required Setting setting}) async {
    return await _.saveByDocumentId(instance: setting);
  }
  Future<bool> existDocumentId({required String documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId,
    );
  }

  Future<void> delete({required int documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

  Future<Setting?> getOne() async {
    return await _.getOneByField(onlyMyData: true,);
  }

  Future<List<Setting>> getList() async {
    return await _.getList(onlyMyData: true);
  }
}
