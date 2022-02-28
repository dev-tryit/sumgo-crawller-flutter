import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/page/KeywordAnalysisPage.dart';
import 'package:kdh_homepage/page/RequestRemovalPage.dart';
import 'package:kdh_homepage/widget/MyChart.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyHeader.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late final KeywordAnylysisPageComponent c;
  List<Future> loadList = [];
  bool isLoaded = false;

  void rebuild() {
    //Flutter는 중간에 state를 제거해놓기도 한다. 추후에 build로 다시 생성하지만..
    //이 때, setState가 불리면, 에러가 발생한다. 따라서, mounted 여부 체크가 필요하다.
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    c = KeywordAnylysisPageComponent(this);
  }

  @override
  void didChangeDependencies() {
    loadList.add(precacheImage(MyImage.backgroundTop, context));
    loadList.add(precacheImage(MyImage.boxIcon, context));
    loadList.add(precacheImage(MyImage.plusIcon, context));
    loadList.add(precacheImage(MyImage.minusIcon, context));
    Future.wait(loadList).then((value) {
      isLoaded = true;
      rebuild();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Scaffold(body: Center(child: MyComponents.loadingWidget()));
    }

    var size = MediaQueryUtil.getScreenSize(context);
    if (PlatformUtil.isMobile()) {
      return Scaffold(body: mobile());
    } else {
      return Scaffold(body: desktop());
    }
  }

  Widget desktop() {
    return Center(
      child: SizedBox(
        width: 350,
        height: double.infinity,
        child: c.body(),
      ),
    );
  }

  Widget mobile() {
    return c.body();
  }
}

class KeywordAnylysisPageComponent {
  final PageController pageC;
  final _LayoutState _state;
  KeywordAnylysisPageComponent(this._state) : pageC = PageController();

  Widget body() {
    return Stack(
      children: [
        Positioned(top: 150, bottom: 0, left: 0, right: 0, child: content()),
        MyHeader(pageC),
      ],
    );
  }

  Widget content() {
    return PageView(
      controller: pageC,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        KeywordAnalysisPage(),
        RequestRemovalPage(),
      ],
    );
  }
}
