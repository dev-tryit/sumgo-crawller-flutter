import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirestoreUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItem.dart';

class AnalysisItemRepository {
  static final FirestoreUtil<AnalysisItem> _ = FirestoreUtil(
    collectionName: StringUtil.classToString(AnalysisItem.empty()),
    fromMap: AnalysisItem.fromMap,
    toMap: AnalysisItem.toMap,
  );

  static Future<AnalysisItem?> add({required AnalysisItem analysisItem}) async {
    return await _.add(instance: analysisItem);
  }

  static Future<bool> existDocumentId({required String documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId,
    );
  }

  static void update(AnalysisItem analysisItem) async {
    await _.updateByDocumentId(
      documentId: analysisItem.documentId ?? "",
      instance: analysisItem,
    );
  }

  static Future<void> delete({required String documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

// static Future<List<AnalysisItem>> getListByUserId(
//     {required String userId}) async {
//   return await _.getListByField(
//     key: "userId",
//     value: userId,
//   );
// }
}
