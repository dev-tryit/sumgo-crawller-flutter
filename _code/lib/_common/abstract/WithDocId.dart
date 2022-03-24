abstract class WithDocId {
  int? documentId;

  WithDocId({this.documentId});
  
  @override
  bool operator ==(dynamic other) => documentId == other.documentId;
}
