import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseStoreUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartStoreUtil.dart';

abstract class FirebaseStoreUtilInterface<Type extends WithDocId> {
  String collectionName;
  Type Function(Map<String, dynamic> map) fromMap;
  Map<String, dynamic> Function(Type instance) toMap;

  FirebaseStoreUtilInterface(
      {required this.collectionName,
      required this.fromMap,
      required this.toMap});

  static FirebaseStoreUtilInterface<Type> init<Type extends WithDocId>(
      {required String collectionName,
      required Type Function(Map<String, dynamic>) fromMap,
      required Map<String, dynamic> Function(Type instance) toMap}) {
    if (PlatformUtil.isComputer()) {
      return FiredartStoreUtil<Type>(
          collectionName: collectionName, fromMap: fromMap, toMap: toMap);
    } else {
      return FirebaseStoreUtil<Type>(
          collectionName: collectionName, fromMap: fromMap, toMap: toMap);
    }
  }

  cRef();

  dRef({int? documentId});

  Future<Map<String, dynamic>> dRefToMap(dRef);

  Type? applyInstance(Map<String, dynamic>? map) =>
      (map == null || map.isEmpty) ? null : fromMap(map);

  Future<Type?> getOneByField(
      {required String key,
      required String value,
      bool useSort = true,
      bool descending = false}) async {
    List<Type?> list = await getListByField(
        key: key, value: value, useSort: useSort, descending: descending);
    return list.isNotEmpty ? list.first : null;
  }

  Future<void> deleteOne({required int documentId}) async {
    return await dRef(documentId: documentId).delete();
  }

  Future<bool> exist({required String key, required String value}) async {
    var data = await getOneByField(key: key, value: value);
    return data != null;
  }

  Future<Type?> getOne(
      {required int documentId,
      required Type Function() onMakeInstance}) async {
    return applyInstance(await dRefToMap(dRef(documentId: documentId)));
  }

  Map<String, dynamic> dSnapshotToMap(dSnapshot);

  List<Type> getListFromDocs(List docs,
      {bool useSort = true, bool descending = false}) {
    List<Type> typeList = List.from(docs
        .map((e) => applyInstance(dSnapshotToMap(e)))
        .where((e) => e != null)
        .toList());

    if (useSort) {
      typeList.sort((a, b) => (((a.documentId ?? 0) < (b.documentId ?? 0))
          ? (descending ? 1 : 0)
          : (descending ? 0 : 1)));
    }

    return typeList;
  }

  Future<List> cRefToList();

  Future<List<Type>> getList(
      {bool useSort = true, bool descending = false}) async {
    return getListFromDocs(await cRefToList(),
        useSort: useSort, descending: descending);
  }

  Future<List> queryToList(query);

  Future<List<Type>> getListByField(
      {required String key,
      required String value,
      bool useSort = true,
      bool descending = false}) async {
    return getListFromDocs(
      await queryToList(cRef().where(key, isEqualTo: value)),
      useSort: useSort,
      descending: descending,
    );
  }

  Future<Type?> saveByDocumentId(
      {required Type instance, int? documentId}) async {
    var ref = dRef(documentId: documentId ?? instance.documentId);
    await ref.set(toMap(instance));
    return applyInstance(await dRefToMap(ref));
  }
}
