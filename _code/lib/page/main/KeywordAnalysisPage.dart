import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHComponent.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHService.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
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
      String title, String keyword, StateSetter setStateOfParent) async {
    void setErrorMessage(String errorMessage) {
      c.errorMessage = errorMessage;
      setStateOfParent(() {});
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
    await AnalysisItemRepository().add(
        analysisItem: AnalysisItem(title: title, keywordList: keywordList));
    await resetAnalysisItemList();
    setStateOfParent(() {});
    await MyComponents.dismissLoadingDialog();

    Navigator.pop(context);
  }
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
                .map((e) => cardListTile(
                    e.title, (e.keywordList ?? []).join(", ".trim())))
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

  ListTile cardListTile(String? title, String? subtitle) {
    title ??= "";
    subtitle ??= "";

    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(top: 6),
        child: Image(image: MyImage.boxIcon),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 6,
      title: MyComponents.text(text: title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      dense: true,
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
                  children: [
                    Text('키워드 분류 생성하기',
                        style: MyFonts.gothicA1(
                            color: MyColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text(errorMessage,
                        style: MyFonts.gothicA1(
                            color: MyColors.red, fontSize: 12)),
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
