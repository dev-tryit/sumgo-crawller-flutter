import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItem.dart';

class AnalysisItemRepository {
  static final AnalysisItemRepository _singleton =
  AnalysisItemRepository._internal();
  factory AnalysisItemRepository() {
    return _singleton;
  }
  AnalysisItemRepository._internal();

  final _ = FirebaseStoreUtilInterface.init(
    collectionName: StringUtil.classToString(AnalysisItem.empty()),
    fromMap: AnalysisItem.fromMap,
    toMap: AnalysisItem.toMap,
  );

  Future<AnalysisItem?> add({required AnalysisItem analysisItem}) async {
    return await _.add(instance: analysisItem);
  }

  Future<bool> existDocumentId({required String documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId,
    );
  }

  void update(AnalysisItem analysisItem) async {
    await _.updateByDocumentId(
      documentId: analysisItem.documentId ?? "",
      instance: analysisItem,
    );
  }

  Future<void> delete({required String documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

// Future<List<AnalysisItem>> getListByUserId(
//     {required String userId}) async {
//   return await _.getListByField(
//     key: "userId",
//     value: userId,
//   );
// }
}
