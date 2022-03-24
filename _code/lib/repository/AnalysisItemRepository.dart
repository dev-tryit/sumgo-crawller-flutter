import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class AnalysisItem extends WithDocId {
  String? title;
  List? keywordList;

  AnalysisItem({required this.title, required this.keywordList}) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  AnalysisItem.empty();

  factory AnalysisItem.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);


  @override
  bool operator ==(dynamic other) => documentId == other.documentId;

  static AnalysisItem fromMap(Map<String, dynamic> map) {
    return AnalysisItem(
      title: map['title'],
      keywordList: map['keywordList'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(AnalysisItem instance) {
    return {
      'documentId': instance.documentId,
      'title': instance.title,
      'keywordList': instance.keywordList,
    };
  }

  static String? getErrorMessageForAdd(String title, String keyword) {
    if (title.isEmpty) return '분류 이름을 입력해주세요';
    if (keyword.isEmpty) return '분류 기준 텍스트를 입력해주세요';
    return null;
  }

}

class AnalysisItemRepository {
  static final AnalysisItemRepository _singleton =
      AnalysisItemRepository._internal();

  factory AnalysisItemRepository() {
    return _singleton;
  }

  AnalysisItemRepository._internal();

  final FirebaseStoreUtilInterface<AnalysisItem> _ =
      FirebaseStoreUtilInterface.init<AnalysisItem>(
    collectionName: StringUtil.classToString(AnalysisItem.empty()),
    fromMap: AnalysisItem.fromMap,
    toMap: AnalysisItem.toMap,
  );

  Future<AnalysisItem?> add({required AnalysisItem analysisItem}) async {
    return await _.saveByDocumentId(instance: analysisItem);
  }

  void update(AnalysisItem analysisItem) async {
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

  Future<AnalysisItem?> getOneByTitle({required String title}) async {
    return await _.getOneByField(
      key: "title",
      value: title,
    );
  }

  Future<List<AnalysisItem>> getList() async {
    return await _.getList();
  }
}
