import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHComponent.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHService.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/AnimationUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItem.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItemRepository.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyCard.dart';
import 'package:sumgo_crawller_flutter/widget/MyChart.dart';
import 'package:sumgo_crawller_flutter/widget/MyRedButton.dart';

class KeywordAnalysisPage extends StatefulWidget {
  const KeywordAnalysisPage({Key? key}) : super(key: key);

  @override
  _KeywordAnalysisPageState createState() => _KeywordAnalysisPageState();
}

class _KeywordAnalysisPageState extends KDHState<KeywordAnalysisPage,
    KeywordAnalysisPageComponent, KeywordAnalysisPageService> {
  @override
  bool isPage() => false;

  @override
  makeComponent() => KeywordAnalysisPageComponent(this);

  @override
  makeService() => KeywordAnalysisPageService(this, c);

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    await s.resetAnalysisItemList();
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => c.body(s);
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class KeywordAnalysisPageComponent
    extends KDHComponent<_KeywordAnalysisPageState> {
  String errorMessage = "";

  KeywordAnalysisPageComponent(_KeywordAnalysisPageState state) : super(state);

  Widget body(KeywordAnalysisPageService s) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          MyCard(
            title: "키워드 분류",
            rightButton: MyRedButton("생성하기",
                onPressed: () => showCreateItemBottomSheet(s)),
            contents: s.analysisItemList
                .map((e) => MyListTile(
                      item: e,
                      s: s,
                    ))
                .toList(),
          ),
          MyCard(title: "연령 분석", contents: [
            MyChart(),
          ]),
          MyCard(title: "연령 분석", contents: [
            MyChart(),
          ]),
        ],
      ),
    );
  }

  void showCreateItemBottomSheet(KeywordAnalysisPageService s) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController keywordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (bottomSheetContext, setState) => Container(
          decoration: const BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('키워드 분류 생성하기',
                        style: MyFonts.gothicA1(
                            color: MyColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    Expanded(
                      child: Text(
                        errorMessage,
                        textAlign: TextAlign.right,
                        style: MyFonts.gothicA1(
                          color: MyColors.red,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    MyRedButton(
                      "생성",
                      useShadow: false,
                      onPressed: () => s.addAnalysisItem(
                        titleController.text.trim(),
                        keywordController.text.trim(),
                        setState,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                minLeadingWidth: 100,
                leading: Text("분류 이름",
                    style: MyFonts.gothicA1(
                        color: MyColors.black, fontSize: 12.5)),
                title: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(isDense: true),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                minLeadingWidth: 100,
                leading: Text("분류 기준 텍스트",
                    style: MyFonts.gothicA1(
                        color: MyColors.black, fontSize: 12.5)),
                title: TextField(
                  controller: keywordController,
                  decoration: const InputDecoration(isDense: true),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class KeywordAnalysisPageService extends KDHService<_KeywordAnalysisPageState,
    KeywordAnalysisPageComponent> {
  List<AnalysisItem> analysisItemList = [];

  KeywordAnalysisPageService(
      _KeywordAnalysisPageState state, KeywordAnalysisPageComponent c)
      : super(state, c);

  Future<void> resetAnalysisItemList() async {
    analysisItemList = await AnalysisItemRepository().getList();
    LogUtil.info("analysisItemList ${analysisItemList}");
  }

  void addAnalysisItem(
      String title, String keyword, StateSetter setStateOfBottomSheet) async {
    void setErrorMessage(String errorMessage) {
      c.errorMessage = errorMessage;
      setStateOfBottomSheet(() {});
    }

    String? errorMessage = AnalysisItem.getErrorMessageForAdd(title, keyword);
    if (errorMessage != null) {
      setErrorMessage(errorMessage);
      return;
    }
    setErrorMessage('');

    await MyComponents.showLoadingDialog(context);
    List<String> keywordList =
        keyword.split(",").map((str) => str.trim()).toList();
    var item = AnalysisItem(
        title: title.replaceAll("분류", ""), keywordList: keywordList);
    await AnalysisItemRepository().add(analysisItem: item);
    analysisItemList.add(item);
    await MyComponents.dismissLoadingDialog();

    Navigator.pop(context);
    rebuild();

    MyComponents.snackBar(context, "생성되었습니다");
  }

  Future<void> deleteAnalysisItem(
      BuildContext context, AnalysisItem item, MyListTile myListTile) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: "알림",
      message: "정말 삭제하시겠습니까?",
      okLabel: "예",
      cancelLabel: "아니오",
    );
    if (result == OkCancelResult.ok) {
      await MyComponents.showLoadingDialog(context);
      await AnalysisItemRepository().delete(documentId: item.documentId ?? -1);
      analysisItemList.remove(item);
      await MyComponents.dismissLoadingDialog();

      if (myListTile.animateController != null) {
        myListTile.animateController!.duration = Duration(milliseconds: 600);
        await myListTile.animateController!.reverse(); //forward or reverse
      }

      rebuild();

      MyComponents.snackBar(context, "삭제되었습니다");
    }
  }
}

class MyListTile extends StatelessWidget {
  AnalysisItem item;
  KeywordAnalysisPageService s;
  AnimationController? animateController;
  MyListTile({Key? key, required this.item, required this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = item.title ?? "";
    String subtitle = (item.keywordList ?? []).join(", ".trim());

    return AnimationUtil.slideInLeft(
      manualTrigger: true,
      duration: const Duration(milliseconds: 0),
      delay: const Duration(milliseconds: 0),
      from: 200,
      controller: (aController) => animateController = aController,
      child: Slidable(
        key: GlobalKey(), //1.반드시 키가 있어야함
        child: ListTile(
          //2. 슬라이드할 대상 설정
          leading: const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Image(image: MyImage.boxIcon),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          horizontalTitleGap: 6,
          title: MyComponents.text(text: "${title} 분류"),
          subtitle:
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
          dense: true,
        ),
        endActionPane: ActionPane(
          //3. startActionPane: 오른쪽으로 드래그하면 나오는액션, endActionPane: 왼쪽
          extentRatio: 0.2, //각각 child의 크기
          motion:
              const BehindMotion(), //동작 애니메이션 설정 BehindMotion, DrawerMotion, ScrollMotion, StretchMotion
          children: [
            CustomSlidableAction(
              onPressed: (c) => s.deleteAnalysisItem(context, item, this),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
