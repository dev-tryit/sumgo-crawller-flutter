import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdh_homepage/_common/abstract/WithDocId.dart';

class FirestoreUtil<Type extends WithDocId> {
  String collectionName;
  Type Function(Map<String, dynamic> map) fromMap;
  Map<String, dynamic> Function(Type instance) toMap;

  FirestoreUtil(
      {required this.collectionName,
      required this.fromMap,
      required this.toMap});

  CollectionReference cRef() =>
      FirebaseFirestore.instance.collection(collectionName);

  DocumentReference dRef({String? documentId}) =>
      documentId != null ? cRef().doc(documentId) : cRef().doc();

  Future<DocumentSnapshot> dRefToSnap(DocumentReference dRef) async =>
      await dRef.get();

  Future<QuerySnapshot> queryToSnap(Query query) async => await query.get();

  Type? applyInstance(Map<String, dynamic>? map) =>
      (map == null || map.isEmpty) ? null : fromMap(map);

  Future<Type?> add({required Type instance}) async {
    DocumentReference ref = dRef();

    instance.documentId = ref.id;

    return await updateByDocumentId(
      instance: instance,
      documentId: ref.id,
    );
  }

  Future<Type?> updateByDocumentId(
      {required Type instance, required String documentId}) async {
    DocumentReference ref = dRef(documentId: documentId);
    await ref.set(toMap(instance));
    return applyInstance(
        (await dRefToSnap(ref)).data() as Map<String, dynamic>?);
  }

  Future<Type?> getOne(
      {required String documentId,
      required Type Function() onMakeInstanc}) async {
    DocumentReference ref = dRef(documentId: documentId);
    return applyInstance(
        (await dRefToSnap(ref)).data() as Map<String, dynamic>?);
  }

  Future<Type?> getOneByField(
      {required String key, required String value}) async {
    List<Type?> list = await getListByField(key: key, value: value);
    return list.isNotEmpty ? list.first : null;
  }

  Future<void> deleteOne({required String documentId}) async {
    return await dRef(documentId: documentId).delete();
  }

  Future<List<Type>> getListByField(
      {required String key, required String value}) async {
    Query query = await cRef().where(key, isEqualTo: value);
    QuerySnapshot querySnapshot = await queryToSnap(query);
    List<Type> list = List.from(querySnapshot.docs
        .map((e) => applyInstance(e.data() as Map<String, dynamic>?))
        .where((e) => e != null)
        .toList());
    return list;
  }

  Future<bool> exist({required String key, required String value}) async {
    var data = await getOneByField(key: key, value: value);
    return data != null;
  }
}
