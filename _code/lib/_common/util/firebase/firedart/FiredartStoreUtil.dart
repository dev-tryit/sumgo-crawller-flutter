// import 'package:firedart/firedart.dart';
// import 'package:sumgo_crawller_flutter/Setting.dart';
// import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';
// import 'package:sumgo_crawller_flutter/_common/util/UUIDUtil.dart';
// import 'package:sumgo_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
//
// class FiredartStoreUtil<Type extends WithDocId>
//     extends FirebaseStoreUtilInterface<Type> {
//   FiredartStoreUtil(
//       {required String collectionName,
//       required Type Function(Map<String, dynamic> map) fromMap,
//       required Map<String, dynamic> Function(Type instance) toMap})
//       : super(collectionName: collectionName, fromMap: fromMap, toMap: toMap) {
//     Firestore.initialize(Setting.firebaseProjectId);
//   }
//
//   @override
//   CollectionReference cRef() {
//     return Firestore.instance.collection(collectionName);
//   }
//
//   @override
//   DocumentReference dRef({String? documentId}) {
//     return documentId != null
//         ? cRef().document(documentId)
//         : cRef().document(UUIDUtil.makeUuid());
//   }
//
//   @override
//   Future<Map<String, dynamic>> dRefToMap(dRef) async => (await dRef.get()).map;
//
//   @override
//   Future<Type?> getOne(
//       {required String documentId,
//       required Type Function() onMakeInstance}) async {
//     DocumentReference ref = dRef(documentId: documentId);
//     return applyInstance((await ref.get()).map);
//   }
//
//   @override
//   Future<List<Type>> getListByField(
//       {required String key, required String value}) async {
//     QueryReference query = cRef().where(key, isEqualTo: value);
//     List<Type> list = List.from((await query.get())
//         .map((e) => applyInstance(e.map))
//         .where((e) => e != null)
//         .toList());
//     return list;
//   }
//
//   @override
//   Future<Type?> add({required Type instance}) async {
//     DocumentReference ref = dRef();
//
//     instance.documentId = ref.id;
//
//     return await updateByDocumentId(
//       instance: instance,
//       documentId: ref.id,
//     );
//   }
//
//   @override
//   Future<Type?> updateByDocumentId(
//       {required Type instance, required String documentId}) async {
//     print("updateByDocumentId");
//     DocumentReference ref = dRef(documentId: documentId);
//     Map<String, dynamic> map = toMap(instance);
//     print("updateByDocumentId1 $map");
//     await ref.set(map);
//     print("updateByDocumentId2");
//     return applyInstance((await ref.get()).map);
//   }
// }
