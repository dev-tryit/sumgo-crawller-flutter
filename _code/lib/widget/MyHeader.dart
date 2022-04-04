import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/page/LoadPage.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyMenu.dart';

class MyHeader extends StatelessWidget {
  final PageController pageC;

  const MyHeader(this.pageC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          const Image(image: MyImage.backgroundTop, fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 19),
              title(context),
              const Spacer(flex: 1),
              MyMenu(pageC: pageC),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Opacity(opacity: 0, child: Icon(Icons.logout)),
          Text(
            "숨고 매니저",
            style: MyFonts.blackHanSans(
              fontSize: 28,
              color: MyColors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              await AuthUtil().logout();
              PageUtil.movePage(context, LoadPage());
            },
            child: const Opacity(
              opacity: 1,
              child: Icon(
                Icons.logout,
                color: MyColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
