import 'package:kdh_homepage/_common/util/FirestoreUtil.dart';
import 'package:kdh_homepage/_common/util/StringUtil.dart';
import 'package:kdh_homepage/repository/AnalysisItem.dart';

class AnalysisItemRepositoryRepository {
  static final FirestoreUtil<AnalysisItem> _ = FirestoreUtil(
    collectionName: StringUtil.classToString(AnalysisItem()),
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
