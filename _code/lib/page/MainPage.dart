import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainPageComponent c;
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
    c = MainPageComponent();
  }

  @override
  void didChangeDependencies() {
    loadList.add(precacheImage(MyImage.blueBackgroundImage, context));
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
    LogUtil.info("size : $size");
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

class MainPageComponent {
  Widget body() {
    return Column(
      children: [header(), Expanded(child: content())],
    );
  }

  Widget header() {
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image(image: MyImage.blueBackgroundImage, fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 19),
              title(),
              const Spacer(flex: 1),
              menu(),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          card(title: "키워드 분류", contens: [
            MyComponents.text(text: "연령 분류"),
            MyComponents.text(text: "의뢰 목적 분류"),
          ]),
          card(title: "연령 분석", contens: []),
        ],
      ),
    );
  }

  Widget menu() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: MyColors.lightBlue),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menuItem("키워드 분석", isChecked: true),
          const SizedBox(width: 35),
          menuItem("요청 정리"),
        ],
      ),
    );
  }

  Widget title() {
    return Text("숨고 매니저",
        style: GoogleFonts.blackHanSans(
          fontSize: 28,
          color: MyColors.white,
        ));
  }

  Widget menuItem(String text, {bool isChecked = false}) {
    return InkWell(
      onTap: () {
        print("click");
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 13,
          right: 13,
          top: 10,
          bottom: 11,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isChecked ? MyColors.deepBlue : Colors.transparent,
        ),
        child: Text(
          text,
          style: GoogleFonts.gothicA1(
            color: MyColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget card({required String title, required List<Widget> contens}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          width: 0.5,
          color: MyColors.black,
        ),
      ),
      shadowColor: MyColors.black,
      elevation: 7,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 24, bottom: 38),
        child: FractionallySizedBox(
          widthFactor: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardTitle(title),
              const SizedBox(height: 23),
              ...contens
            ],
          ),
        ),
      ),
    );
  }

  Widget redButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: GoogleFonts.gothicA1(
          color: MyColors.white,
          fontSize: 12.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: MyColors.black,
        elevation: 7,
        padding:
            const EdgeInsets.only(left: 23, right: 23, top: 14, bottom: 14),
        primary: MyColors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Widget cardTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.gothicA1(
            color: MyColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        redButton("생성하기"),
      ],
    );
  }
}
