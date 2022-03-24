import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class RemovalCondition extends WithDocId {
  String? type;
  String? content;

  RemovalCondition({required this.type, required this.content}) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  RemovalCondition.empty();

  factory RemovalCondition.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static RemovalCondition fromMap(Map<String, dynamic> map) {
    return RemovalCondition(
      type: map['type'],
      content: map['content'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(RemovalCondition instance) {
    return {
      'documentId': instance.documentId,
      'type': instance.type,
      'content': instance.content,
    };
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

  Future<RemovalCondition?> add({required RemovalCondition analysisItem}) async {
    return await _.saveByDocumentId(instance: analysisItem);
  }

  void update(RemovalCondition analysisItem) async {
    await _.saveByDocumentId(
      instance: analysisItem,
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
}
