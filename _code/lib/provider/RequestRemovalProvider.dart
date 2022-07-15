
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MySetting.dart';
import '../_common/interface/Type.dart';
import '../_common/util/PlatformUtil.dart';
import '../_common/util/UrlUtil.dart';
import '../dialog/SettingDialog.dart';
import '../repository/RemovalConditionRepository.dart';
import '../repository/SettingRepository.dart';
import '../util/MyComponents.dart';
import '../util/MyCrawller.dart';
import '../widget/SelectRemovalType.dart';

class RequestRemovalProvider extends ChangeNotifier {
  List<RemovalCondition> removalConditionList = [];

  BuildContext context;

  RequestRemovalProvider(this.context);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<RequestRemovalProvider>(
          create: (context) => RequestRemovalProvider(context));

  static Widget consumer(
          {required ConsumerBuilderType<RequestRemovalProvider> builder}) =>
      Consumer<RequestRemovalProvider>(builder: builder);

  static RequestRemovalProvider read(BuildContext context) =>
      context.read<RequestRemovalProvider>();


  Future<void> resetRemovalConditionList() async {
    removalConditionList = await RemovalConditionRepository().getList();
  }

  Future<void> removeRequests() async {
    if (PlatformUtil.isWeb()) {
      await showOkAlertDialog(
        context: context,
        title: "알림",
        message: "웹에서는 요청 정리를 할 수 없습니다. Windows 프로그램을 이용해주세요",
        okLabel: "다운로드",
      );
      await UrlUtil().openUrl(
          'https://github.com/dev-tryit/sumgo_crawller_flutter/raw/master/deploy/SumgoManager.zip');
      return;
    }

    Setting? setting = await SettingRepository().getOne();
    if (setting == null ||
        (setting.sumgoId ?? "").isEmpty ||
        (setting.sumgoPw ?? "").isEmpty) {
      await showOkAlertDialog(
        context: context,
        title: "알림",
        message: "${MySetting.appName} 설정이 필요합니다.",
      );
      SettingDialog.show(context);
      return;
    }

    await MyComponents.showLoadingDialog(context);
    final List<String> listToIncludeAlways = (await RemovalConditionRepository()
        .getListByType(type: RemovalType.best.value))
        .map((e) => e.content ?? "")
        .toList();
    final List<String> listToInclude = (await RemovalConditionRepository()
        .getListByType(type: RemovalType.include.value))
        .map((e) => e.content ?? "")
        .toList();
    final List<String> listToExclude = (await RemovalConditionRepository()
        .getListByType(type: RemovalType.exclude.value))
        .map((e) => e.content ?? "")
        .toList();
    await MyComponents.dismissLoadingDialog();

    try {
      await MyComponents.showLoadingDialog(context);
      await MyCrawller(
        listToIncludeAlways: listToIncludeAlways,
        listToInclude: listToInclude,
        listToExclude: listToExclude,
      ).start(setting);
    } finally {
      await MyComponents.dismissLoadingDialog();
    }
  }

  Future<void> addRemovalCondition(
      String content,
      String type,
      String typeDisplay,
      void Function(String errorMessage) setErrorMessage) async {
    String? errorMessage =
    RemovalCondition.getErrorMessageForAdd(content, type, typeDisplay);
    if (errorMessage != null) {
      setErrorMessage(errorMessage);
      return;
    }
    setErrorMessage('');

    var item = RemovalCondition(
        content: content, type: type, typeDisplay: typeDisplay);

    removalConditionList.add(item);
    RemovalConditionRepository().add(removalCondition: item);

    Navigator.pop(context);
    notifyListeners();

    MyComponents.snackBar(context, "생성되었습니다");
  }

  Future<void> deleteRemovalCondition(BuildContext context,
      RemovalCondition item, AnimationController? animateController) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: "알림",
      message: "정말 삭제하시겠습니까?",
      okLabel: "예",
      cancelLabel: "아니오",
    );
    if (result == OkCancelResult.ok) {
      if (animateController != null) {
        animateController.duration =
        const Duration(milliseconds: 100);
        await animateController.reverse(); //forward or reverse
      }

      removalConditionList.remove(item);
      RemovalConditionRepository().delete(documentId: item.documentId ?? -1);

      notifyListeners();

      MyComponents.snackBar(context, "삭제되었습니다");
    }
  }
}
