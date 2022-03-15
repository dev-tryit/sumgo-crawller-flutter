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
  Future<Type?> updateByDocumentId(
      {required Type instance, required String documentId}) async {
    DocumentReference ref = dRef(documentId: documentId);
    await ref.set(toMap(instance));
    return applyInstance((await dRefToMap(ref)));
  }

  @override
  Future<Type?> getOne(
      {required String documentId,
      required Type Function() onMakeInstanc}) async {
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
}
