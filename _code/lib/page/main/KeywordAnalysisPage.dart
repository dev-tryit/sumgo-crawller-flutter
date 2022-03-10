import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItem.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItemRepository.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyCard.dart';
import 'package:sumgo_crawller_flutter/widget/MyChart.dart';
import 'package:sumgo_crawller_flutter/widget/MyRedButton.dart';

class KeywordAnalysisPage extends StatefulWidget {
  const KeywordAnalysisPage({Key? key}) : super(key: key);

  @override
  _KeywordAnalysisPageState createState() => _KeywordAnalysisPageState();
}

class _KeywordAnalysisPageState extends State<KeywordAnalysisPage> {
  late final KeywordAnalysisPageService s;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    s = KeywordAnalysisPageService(this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          MyCard(
            title: "키워드 분류",
            rightButton:
                MyRedButton("생성하기", onPressed: showCreateItemBottomSheet),
            contents: [
              cardListTile("연령 분류", "학업, 취미/자기개발, 학업, 취미/자기개발"),
              cardListTile(
                  "의뢰 목적 분류", "학업, 취미/자기개발, 학업, 취미/자기개발, 학업, 취미/자리..."),
            ],
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

  ListTile cardListTile(String title, String subtitle) {
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

  void showCreateItemBottomSheet() {
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
                        style: GoogleFonts.gothicA1(
                            color: MyColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text(errorMessage,
                        style: GoogleFonts.gothicA1(
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
                    style: GoogleFonts.gothicA1(
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
                    style: GoogleFonts.gothicA1(
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

class KeywordAnalysisPageService {
  final _KeywordAnalysisPageState state;

  const KeywordAnalysisPageService(this.state);

  BuildContext get context => state.context;

  void addAnalysisItem(String title, String keyword, StateSetter setState) {
    void setErrorMessage(String errorMessage) {
      state.errorMessage = errorMessage;
      setState(() {});
    }

    String? errorMessage = AnalysisItem.getErrorMessageForAdd(title, keyword);
    if (errorMessage != null) {
      LogUtil.info("에러있음 $errorMessage");
      setErrorMessage(errorMessage);
      return;
    }
    setErrorMessage('');

    List<String> keywordList =
        keyword.split(",").map((str) => str.trim()).toList();
    LogUtil.info("에러없음 $keywordList");
    AnalysisItemRepository.add(
        analysisItem: AnalysisItem(title: title, keywordList: keywordList));
    Navigator.pop(context);
  }
}
