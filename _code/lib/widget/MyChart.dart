import 'dart:async';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/ColorUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItemRepository.dart';
import 'package:sumgo_crawller_flutter/repository/KeywordItemRepository.dart';

class MyChart extends StatefulWidget {
  final AnalysisItem analysisItem;
  const MyChart(this.analysisItem, {Key? key}) : super(key: key);

  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState
    extends KDHState<MyChart> {
  Map<String, double> percentByKeyword = {};

  List<PieChartSectionData> sectionDataList = [];
  List<Color> colorList = [];
  int touchedIndex = -1;
  final gridViewCount = 3;
  final scrollController = ScrollController();

  @override
  bool isPage() => false;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    List<KeywordItem> keywordItemList = [];
    try {
      keywordItemList = List.from((await Future.wait(
          (widget.analysisItem.keywordList ?? []).map((keyword) =>
              KeywordItemRepository().getKeywordItem(keyword: keyword))))
          .where((element) => element != null));
    } catch (e) {
      keywordItemList = [];
    }

    percentByKeyword = {};
    for (var keywordItem in keywordItemList) {
      var keyword = keywordItem.keyword ?? "";
      if (!percentByKeyword.containsKey(keyword)) {
        percentByKeyword[keyword] = 0;
      }

      percentByKeyword[keyword] = (keywordItem.count ?? 0.0).toDouble();
    }

    colorList = (widget.analysisItem.keywordList ?? [])
        .map((e) => ColorUtil.random())
        .toList();
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => body(widget);
    rebuild();
  }

  Widget body( MyChart widget) {
    int i = 0;
    sectionDataList = [];
    for (MapEntry<String, double> entry in percentByKeyword.entries) {
      final color = colorList[i];
      final isTouched = touchedIndex == i;
      sectionDataList.add(
        PieChartSectionData(
          title: entry.key,
          value: entry.value,
          color: color.withOpacity(isTouched ? 1.0 : 0.7),
          showTitle: false,
          radius: 50,
          borderSide: isTouched
              ? BorderSide(color: color, width: 6)
              : BorderSide(color: color.withOpacity(0)),
        ),
      );

      i++;
    }

    return sectionDataList.isNotEmpty
        ? Column(
      children: <Widget>[
        const SizedBox(height: 20),
        header(),
        const SizedBox(height: 18),
        SizedBox(
          width: 100,
          height: 100,
          child: chart(),
        ),
      ],
    )
        : Text("관련 데이터가 없습니다");
  }

  Widget header() {
    return DynamicHeightGridView(
      shrinkWrap: true,
      itemCount: sectionDataList.length,
      crossAxisCount: gridViewCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      builder: (c, i) {
        final sectionData = sectionDataList[i];

        final isTouched = touchedIndex == i;
        return Indicator(
          color: sectionData.color.withOpacity(isTouched ? 1.0 : 0.7),
          text: sectionData.title,
          isSquare: false,
          size: isTouched ? 18 : 16,
          textColor: isTouched ? Colors.black : Colors.grey,
        );
      },
    );
  }

  PieChart chart() {
    return PieChart(
      PieChartData(
          pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                rebuild();
              }),
          startDegreeOffset: 180,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 1,
          centerSpaceRadius: 0,
          sections: sectionDataList),
    );
  }

  @override
  Future<void> afterBuild() async {}

  //Provider 데이터
  Future<void> init(MyChart widget) async {
  }

}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: textColor,
                overflow: TextOverflow.ellipsis),
          ),
        )
      ],
    );
  }
}
