import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseStoreUtil.dart';
import 'package:sumgo_crawller_flutter/repository/KeywordItem.dart';

class KeywordItemRepository {
  static final FirebaseStoreUtil<KeywordItem> _ = FirebaseStoreUtil(
    collectionName: StringUtil.classToString(KeywordItem.empty()),
    fromMap: KeywordItem.fromMap,
    toMap: KeywordItem.toMap,
  );

  static Future<KeywordItem?> add({required KeywordItem keywordItem}) async {
    return await _.add(instance: keywordItem);
  }

  static Future<bool> existDocumentId({required String documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId,
    );
  }

  static Future<void> update(KeywordItem keywordItem) async {
    await _.updateByDocumentId(
      documentId: keywordItem.documentId ?? "",
      instance: keywordItem,
    );
  }

  static Future<void> delete({required String documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

  static Future<KeywordItem?> getKeywordItem(
      {required String keyword}) async {
    return await _.getOneByField(
      key: "keyword",
      value: keyword,
    );
  }
}
