import 'package:sumgo_crawller_flutter/_common/abstract/WithDocId.dart';

class KeywordItem extends WithDocId {
  String? keyword;
  int? count;

  KeywordItem({required this.keyword, required this.count})
      : super(documentId: DateTime.now().microsecondsSinceEpoch);

  KeywordItem.empty();

  factory KeywordItem.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static KeywordItem fromMap(Map<String, dynamic> map) {
    return KeywordItem(
      keyword: map['keyword'],
      count: map['count'],
    )..documentId = map['documentId'];
  }

  static Map<String, dynamic> toMap(KeywordItem instance) {
    return {
      'documentId': instance.documentId,
      'keyword': instance.keyword,
      'count': instance.count,
    };
  }

  static String? getErrorMessageForAdd(String title, String keyword) {
    if (title.isEmpty) return '분류 이름을 입력해주세요';
    if (keyword.isEmpty) return '분류 기준 텍스트를 입력해주세요';
    return null;
  }
}
