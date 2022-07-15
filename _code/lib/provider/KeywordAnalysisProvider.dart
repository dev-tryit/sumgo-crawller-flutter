import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../_common/interface/ConsumerBuilderType.dart';
import '../repository/AnalysisItemRepository.dart';
import '../util/MyComponents.dart';

class KeywordAnalysisProvider extends ChangeNotifier {
  List<AnalysisItem> analysisItemList = [];

  BuildContext context;

  KeywordAnalysisProvider(this.context);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<KeywordAnalysisProvider>(
          create: (context) => KeywordAnalysisProvider(context));

  static Widget consumer(
          {required ConsumerBuilderType<KeywordAnalysisProvider> builder}) =>
      Consumer<KeywordAnalysisProvider>(builder: builder);

  static KeywordAnalysisProvider read(BuildContext context) =>
      context.read<KeywordAnalysisProvider>();

  Future<void> resetAnalysisItemList() async {
    analysisItemList = await AnalysisItemRepository().getList();
  }

  void addAnalysisItem(
      String title,
      String keyword,
      void Function(String errorMessage) setErrorMessage,
      ScrollController scrollController) async {
    String? errorMessage = AnalysisItem.getErrorMessageForAdd(title, keyword);
    if (errorMessage != null) {
      setErrorMessage(errorMessage);
      return;
    }
    setErrorMessage('');

    List<String> keywordList =
        keyword.split(",").map((str) => str.trim()).toList();
    var item = AnalysisItem(
        title: title.replaceAll("분류", ""), keywordList: keywordList);

    analysisItemList.add(item);
    AnalysisItemRepository().add(analysisItem: item);

    Navigator.pop(context);

    notifyListeners();

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    MyComponents.snackBar(context, "생성되었습니다");
  }

  Future<void> deleteAnalysisItem(BuildContext context,
      AnalysisItem currentItem, AnimationController? animateController) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: "알림",
      message: "정말 삭제하시겠습니까?",
      okLabel: "예",
      cancelLabel: "아니오",
    );
    if (result == OkCancelResult.ok) {
      if (animateController != null) {
        animateController.duration = const Duration(milliseconds: 100);
        await animateController.reverse(); //forward or reverse
      }

      analysisItemList.remove(currentItem);
      AnalysisItemRepository().delete(documentId: currentItem.documentId ?? -1);

      notifyListeners();

      MyComponents.snackBar(context, "삭제되었습니다");
    }
  }

  Future<void> updateAnalysisItem(
    BuildContext context,
    String title,
    String keyword,
    AnalysisItem currentItem,
    void Function(String errorMessage) setErrorMessage,
  ) async {
    String? errorMessage = AnalysisItem.getErrorMessageForAdd(title, keyword);
    if (errorMessage != null) {
      setErrorMessage(errorMessage);
      return;
    }
    setErrorMessage('');

    List<String> keywordList =
        keyword.split(",").map((str) => str.trim()).toList();

    AnalysisItemRepository().update(currentItem..title=title.replaceAll("분류", "")..keywordList=keywordList);

    Navigator.pop(context);

    notifyListeners();

    MyComponents.snackBar(context, "수정되었습니다");
  }
}
