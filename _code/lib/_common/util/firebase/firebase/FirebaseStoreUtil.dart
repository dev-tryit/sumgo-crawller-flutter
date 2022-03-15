import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class FirebaseStoreUtil<Type extends WithDocId>
    extends FirebaseStoreUtilInterface<Type> {
  FirebaseStoreUtil(
      {required String collectionName,
      required Type Function(Map<String, dynamic> map) fromMap,
      required Map<String, dynamic> Function(Type instance) toMap})
      : super(collectionName: collectionName, fromMap: fromMap, toMap: toMap);

  @override
  CollectionReference cRef() =>
      FirebaseFirestore.instance.collection(collectionName);

  @override
  DocumentReference dRef({String? documentId}) =>
      documentId != null ? cRef().doc(documentId) : cRef().doc();

  @override
  Future<Map<String, dynamic>> dRefToMap(dRef) async =>
      ((await dRef.get()).data() as Map<String, dynamic>?) ?? {};

  @override
  Future<Type?> getOne(
      {required String documentId,
      required Type Function() onMakeInstance}) async {
    DocumentReference ref = dRef(documentId: documentId);
    return applyInstance((await dRefToMap(ref)));
  }

  @override
  Future<List<Type>> getListByField(
      {required String key, required String value}) async {
    Query query = cRef().where(key, isEqualTo: value);
    List<Type> list = List.from((await query.get())
        .docs
        .map((e) => applyInstance(e.data() as Map<String, dynamic>?))
        .where((e) => e != null)
        .toList());
    return list;
  }

  @override
  Future<Type?> add({required Type instance}) async {
    DocumentReference ref = dRef();

    instance.documentId = ref.id;

    return await updateByDocumentId(
      instance: instance,
      documentId: ref.id,
    );
  }

  @override
  Future<Type?> updateByDocumentId(
      {required Type instance, required String documentId}) async {
    print("updateByDocumentId");
    DocumentReference ref = dRef(documentId: documentId);
    Map<String, dynamic> map = toMap(instance);
    print("updateByDocumentId1 $map");
    await ref.set(map);
    print("updateByDocumentId2");
    return applyInstance((await ref.get()).data() as Map<String, dynamic>?);
  }
}
