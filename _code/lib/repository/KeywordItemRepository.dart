import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
import 'package:sumgo_crawller_flutter/repository/KeywordItem.dart';

class KeywordItemRepository {
  static final KeywordItemRepository _singleton =
      KeywordItemRepository._internal();
  factory KeywordItemRepository() {
    return _singleton;
  }
  KeywordItemRepository._internal();

  final _ = FirebaseStoreUtilInterface.init<KeywordItem>(
    collectionName: StringUtil.classToString(KeywordItem.empty()),
    fromMap: KeywordItem.fromMap,
    toMap: KeywordItem.toMap,
  );

  Future<KeywordItem?> add({required KeywordItem keywordItem}) async {
    return await _.saveByDocumentId(instance: keywordItem);
  }

  Future<void> update(KeywordItem keywordItem) async {
    await _.saveByDocumentId(
      instance: keywordItem,
    );
  }

  Future<bool> existDocumentId({required int documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId.toString(),
    );
  }

  Future<void> delete({required int documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

  Future<KeywordItem?> getKeywordItem({required String keyword}) async {
    return await _.getOneByField(
      key: "keyword",
      value: keyword,
    );
  }
}
