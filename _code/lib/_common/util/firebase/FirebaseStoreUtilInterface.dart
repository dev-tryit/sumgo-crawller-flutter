import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseStoreUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartStoreUtil.dart';

abstract class FirebaseStoreUtilInterface<Type extends WithDocId,
    CollectionReference, DocumentReference> {
  String collectionName;
  Type Function(Map<String, dynamic> map) fromMap;
  Map<String, dynamic> Function(Type instance) toMap;

  FirebaseStoreUtilInterface(
      {required this.collectionName,
      required this.fromMap,
      required this.toMap});

  static init<Type extends WithDocId>({collectionName, fromMap, toMap}) {
    if (PlatformUtil.isComputer()) {
      return FiredartStoreUtil<Type>(
          collectionName: collectionName, fromMap: fromMap, toMap: toMap);
    } else {
      return FirebaseStoreUtil<Type>(
          collectionName: collectionName, fromMap: fromMap, toMap: toMap);
    }
  }

  CollectionReference cRef();

  DocumentReference dRef({String? documentId});

  Future<Map<String, dynamic>> dRefToMap(DocumentReference dRef);

  Type? applyInstance(Map<String, dynamic>? map) =>
      (map == null || map.isEmpty) ? null : fromMap(map);

  Future<Type?> add({required Type instance});

  Future<Type?> updateByDocumentId(
      {required Type instance, required String documentId});

  Future<Type?> getOne(
      {required String documentId, required Type Function() onMakeInstanc});

  Future<Type?> getOneByField({required String key, required String value});

  Future<void> deleteOne({required String documentId});

  Future<List<Type>> getListByField(
      {required String key, required String value});

  Future<bool> exist({required String key, required String value});
}
