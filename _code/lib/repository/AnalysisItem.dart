import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';

class AnalysisItem extends WithDocId {
  String? title;
  List? keywordList;

  AnalysisItem({required this.title, required this.keywordList}) : super(documentId: DateTime.now().microsecondsSinceEpoch);

  AnalysisItem.empty();

  factory AnalysisItem.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);


  @override
  bool operator ==(dynamic other) => documentId == other.documentId;

  static AnalysisItem fromMap(Map<String, dynamic> map) {
    return AnalysisItem(
      title: map['title'],
      keywordList: map['keywordList'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(AnalysisItem instance) {
    return {
      'documentId': instance.documentId,
      'title': instance.title,
      'keywordList': instance.keywordList,
    };
  }

  static String? getErrorMessageForAdd(String title, String keyword) {
    if (title.isEmpty) return '분류 이름을 입력해주세요';
    if (keyword.isEmpty) return '분류 기준 텍스트를 입력해주세요';
    return null;
  }

}
