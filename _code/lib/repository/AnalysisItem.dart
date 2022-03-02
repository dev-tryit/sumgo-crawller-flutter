import 'package:kdh_homepage/_common/abstract/WithDocId.dart';

class AnalysisItem extends WithDocId {
  String? title;
  List? keywordList;

  AnalysisItem({String? documentId, this.title, this.keywordList})
      : super(documentId: documentId);

  factory AnalysisItem.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static AnalysisItem fromMap(Map<String, dynamic> map) {
    return AnalysisItem(
      documentId: map['documentId'],
      title: map['title'],
      keywordList: map['keywordList'],
    );
  }

  static Map<String, dynamic> toMap(AnalysisItem instance) {
    return {
      'documentId': instance.documentId,
      'title': instance.title,
      'keywordList': instance.keywordList,
    };
  }
}
