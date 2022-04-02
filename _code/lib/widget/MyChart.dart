import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/ColorUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/SizeUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItemRepository.dart';

class MyChart extends StatefulWidget {
  final AnalysisItem analysisItem;
  const MyChart(this.analysisItem, {Key? key}) : super(key: key);

  @override
  MyChartState createState() => MyChartState();
}

class MyChartState extends State<MyChart> {
  List<PieChartSectionData> sectionDataList = [];
  List<Color> colorList = [];
  int touchedIndex = -1;

  final gridViewCount = 3;

  @override
  void initState() {
    // TODO:keyword 바탕으로 KeywordItem 모두 갖고오기.
    // keywordItem을 바탕으로 {키워드,퍼센트} 만들기
    /*
    // [
    //   PieChartSectionData(
    //     color: color0.withOpacity(opacity),
    //     value: 25,
    //     title: '',
    //     radius: 80,
    //     titleStyle: const TextStyle(
    //         fontSize: 18,
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff044d7c)),
    //     titlePositionPercentageOffset: 0.55,
    //     borderSide: isTouched
    //         ? BorderSide(color: color0, width: 6)
    //         : BorderSide(color: color0.withOpacity(0)),
    //   ),
    // ];
    */
    colorList = (widget.analysisItem.keywordList ?? [])
        .map((e) => ColorUtil.random())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    sectionDataList = (widget.analysisItem.keywordList ?? [])
        .asMap()
        .map((i, keyword) {
          final color = colorList[i];
          final isTouched = touchedIndex == i;
          return MapEntry(
              i,
              PieChartSectionData(
                title: keyword,
                color: color.withOpacity(isTouched ? 1.0 : 0.7),
                showTitle: false,
                radius: 50,
                borderSide: isTouched
                    ? BorderSide(color: color, width: 6)
                    : BorderSide(color: color.withOpacity(0)),
              ));
        })
        .values
        .toList();

    return Column(
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
    );
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
            setState(() {});
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
