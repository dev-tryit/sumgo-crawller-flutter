import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
import 'package:sumgo_crawller_flutter/widget/SelectRemovalType.dart';

class RemovalCondition extends WithDocId {
  String? type;
  String? content;
  String? typeDisplay;

  RemovalCondition({required this.type, required this.content, required this.typeDisplay})
      : super(documentId: DateTime.now().microsecondsSinceEpoch);

  RemovalCondition.empty();

  factory RemovalCondition.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static RemovalCondition fromMap(Map<String, dynamic> map) {
    return RemovalCondition(
      type: map['type'],
      content: map['content'],
      typeDisplay: map['typeDisplay'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(RemovalCondition instance) {
    return {
      'documentId': instance.documentId,
      'type': instance.type,
      'content': instance.content,
      'typeDisplay': instance.typeDisplay,
    };
  }

  static String? getErrorMessageForAdd(String content, String type, String typeDisplay) {
    if (content.isEmpty) return '내용을 입력해주세요';
    if (type.isEmpty || typeDisplay.isEmpty) return '정리 타입을 선택해주세요';
    if (RemovalType.values.where((element) => element.value == type).isEmpty) {
      return '잘못된 정리 타입입니다.';
    }
    return null;
  }
}

class RemovalConditionRepository {
  static final RemovalConditionRepository _singleton =
      RemovalConditionRepository._internal();

  factory RemovalConditionRepository() {
    return _singleton;
  }

  RemovalConditionRepository._internal();

  final FirebaseStoreUtilInterface<RemovalCondition> _ =
      FirebaseStoreUtilInterface.init<RemovalCondition>(
    collectionName: StringUtil.classToString(RemovalCondition.empty()),
    fromMap: RemovalCondition.fromMap,
    toMap: RemovalCondition.toMap,
  );

  Future<RemovalCondition?> add(
      {required RemovalCondition removalCondition}) async {
    return await _.saveByDocumentId(instance: removalCondition);
  }

  void update(RemovalCondition removalCondition) async {
    await _.saveByDocumentId(
      instance: removalCondition,
    );
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

  Future<RemovalCondition?> getOneByTitle({required String title}) async {
    return await _.getOneByField(
      key: "title",
      value: title,
    );
  }

  Future<List<RemovalCondition>> getList() async {
    return await _.getList();
  }
  
  Future<List<RemovalCondition>> getListByType({required String type}) async {
    return await _.getListByField(
      key: "type",
      value: type,
    );
  }
}
