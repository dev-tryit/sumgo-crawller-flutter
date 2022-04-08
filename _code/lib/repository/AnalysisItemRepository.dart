import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class AnalysisItem extends WithDocId {
  static const String className = "AnalysisItem";
  String? title;
  List? keywordList;

  AnalysisItem({required this.title, required this.keywordList}) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  factory AnalysisItem.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static AnalysisItem fromMap(Map<String, dynamic> map) {
    return AnalysisItem(
      title: map['title'],
      keywordList: map['keywordList'],
    )
    ..documentId = map['documentId']
    ..email = map['email'];
  }

  static Map<String, dynamic> toMap(AnalysisItem instance) {
    return {
      'documentId': instance.documentId,
      'email': instance.email,
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
    collectionName: AnalysisItem.className,
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

  Future<List<AnalysisItem>> getList() async {
    return await _.getList(onlyMyData:true);
  }
}
