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
  late final List<PieChartSectionData> sectionDataList;
  int touchedIndex = -1;

  final gridViewCount = 4;

  @override
  void initState() {
    // keyword 바탕으로 KeywordItem 모두 갖고오기.
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

    // 해당 맵으로 PieChartSectionData 만들기
    sectionDataList = (widget.analysisItem.keywordList ?? []).map((keyword) {
      return PieChartSectionData(
        title: keyword,
        color: ColorUtil.random(),
        showTitle: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          header(),
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: chart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return GridView.count(
      crossAxisCount: gridViewCount,
      childAspectRatio: 2.3,
      shrinkWrap: true,
      children: sectionDataList
          .asMap()
          .map((i, sectionData) => MapEntry(
              i,
              Indicator(
                color: const Color(0xff0293ee),
                text: sectionData.title,
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
              )))
          .values
          .toList(),
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
            LogUtil.info("touch");
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

  // return List.generate(
  //   4,
  //   (i) {
  //     final isTouched = i == touchedIndex;
  //     final opacity = isTouched ? 1.0 : 0.6;

  //     const color0 = Color(0xff0293ee);
  //     const color1 = Color(0xfff8b250);
  //     const color2 = Color(0xff845bef);
  //     const color3 = Color(0xff13d38e);

  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color: color0.withOpacity(opacity),
  //           value: 25,
  //           title: '',
  //           radius: 80,
  //           titleStyle: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xff044d7c)),
  //           titlePositionPercentageOffset: 0.55,
  //           borderSide: isTouched
  //               ? BorderSide(color: color0, width: 6)
  //               : BorderSide(color: color0.withOpacity(0)),
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color: color1.withOpacity(opacity),
  //           value: 25,
  //           title: '',
  //           radius: 65,
  //           titleStyle: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xff90672d)),
  //           titlePositionPercentageOffset: 0.55,
  //           borderSide: isTouched
  //               ? BorderSide(color: color1, width: 6)
  //               : BorderSide(color: color2.withOpacity(0)),
  //         );
  //       case 2:
  //         return PieChartSectionData(
  //           color: color2.withOpacity(opacity),
  //           value: 25,
  //           title: '',
  //           radius: 60,
  //           titleStyle: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xff4c3788)),
  //           titlePositionPercentageOffset: 0.6,
  //           borderSide: isTouched
  //               ? BorderSide(color: color2, width: 6)
  //               : BorderSide(color: color2.withOpacity(0)),
  //         );
  //       case 3:
  //         return PieChartSectionData(
  //           color: color3.withOpacity(opacity),
  //           value: 25,
  //           title: '',
  //           radius: 100,
  //           titleStyle: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xff0c7f55)),
  //           titlePositionPercentageOffset: 0.55,
  //           borderSide: isTouched
  //               ? BorderSide(color: color3, width: 6)
  //               : BorderSide(color: color2.withOpacity(0)),
  //         );
  //       default:
  //         throw Error();
  //     }
  //   },
  // );
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
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
