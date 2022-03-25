import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHComponent.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHService.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/repository/RemovalConditionRepository.dart';
import 'package:sumgo_crawller_flutter/util/MyBottomSheetUtil.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyCrawller.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyCard.dart';
import 'package:sumgo_crawller_flutter/widget/MyRedButton.dart';
import 'package:sumgo_crawller_flutter/widget/MyWhiteButton.dart';
import 'package:sumgo_crawller_flutter/widget/SelectRemovalType.dart';

class RequestRemovalPage extends StatefulWidget {
  const RequestRemovalPage({Key? key}) : super(key: key);

  @override
  _RequestRemovalPageState createState() => _RequestRemovalPageState();
}

class _RequestRemovalPageState extends KDHState<RequestRemovalPage,
    RequestRemovalPageComponent, RequestRemovalPageService> {
  @override
  bool isPage() => false;

  @override
  makeComponent() => RequestRemovalPageComponent(this);

  @override
  makeService() => RequestRemovalPageService(this, c);

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    await s.resetRemovalConditionList();
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => c.body(s);
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class RequestRemovalPageComponent
    extends KDHComponent<_RequestRemovalPageState> {
  RequestRemovalPageComponent(_RequestRemovalPageState state) : super(state);

  Widget body(RequestRemovalPageService s) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          MyCard(
            title: "정리 조건",
            rightButton: MyRedButton("생성하기",
                onPressed: () => showCreateItemBottomSheet(s)),
            contents: [
              cardListTile("[최우선키워드] Flutter"),
              cardListTile("[최우선키워드] Flutter"),
              cardListTile("[포함] Flutter"),
              cardListTile("[포함] Flutter"),
              cardListTile("[포함] Flutter", isPlusIcon: false),
              cardListTile("[제외] Flutter", isPlusIcon: false),
              cardListTile("[제외] Flutter", isPlusIcon: false),
            ],
            bottomButton: MyWhiteButton("요청 정리하기", onPressed: s.removeRequests),
          ),
        ],
      ),
    );
  }

  ListTile cardListTile(String title, {bool isPlusIcon = true}) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(top: 6),
        child:
            Image(image: (isPlusIcon ? MyImage.plusIcon : MyImage.minusIcon)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 6,
      title: MyComponents.text(text: title),
      dense: true,
    );
  }

  void showCreateItemBottomSheet(RequestRemovalPageService s) {
    final TextEditingController contentController = TextEditingController();

    MyBottomSheetUtil.showInputBottomSheet(
      context: context,
      title: '정리 조건 생성하기',
      children: [
        const SelectRemovalType(),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          minLeadingWidth: 100,
          leading: Text("내용",
              style: MyFonts.gothicA1(color: MyColors.black, fontSize: 12.5)),
          title: TextField(
            controller: contentController,
            decoration: const InputDecoration(isDense: true),
          ),
        ),
        const SizedBox(height: 10),
      ],
      buttonStr: "생성",
      onAdd: (setErrorMessage) => s.addRemovalCondition(
        contentController.text.trim(),
        setErrorMessage,
      ),
    );
  }
}

class RequestRemovalPageService
    extends KDHService<_RequestRemovalPageState, RequestRemovalPageComponent> {
  List<RemovalCondition> removalConditionList = [];

  RequestRemovalPageService(
      _RequestRemovalPageState state, RequestRemovalPageComponent c)
      : super(state, c);

  Future<void> removeRequests() async {
    try {
      await MyComponents.showLoadingDialog(context);
      await MyCrawller().start();
    } finally {
      await MyComponents.dismissLoadingDialog();
    }
  }

  Future<void> addRemovalCondition(
      String content, void Function(String errorMessage) setErrorMessage) async {
    // String? errorMessage = AnalysisItem.getErrorMessageForAdd(title, keyword);
    // if (errorMessage != null) {
    //   setErrorMessage(errorMessage);
    //   return;
    // }
    // setErrorMessage('');

    // List<String> keywordList =
    //     keyword.split(",").map((str) => str.trim()).toList();
    // var item = AnalysisItem(
    //     title: title.replaceAll("분류", ""), keywordList: keywordList);

    // analysisItemList.add(item);
    // AnalysisItemRepository().add(analysisItem: item);

    // Navigator.pop(context);
    // rebuild();

    // MyComponents.snackBar(context, "생성되었습니다");
  }

  Future<void> resetRemovalConditionList() async {}
}
