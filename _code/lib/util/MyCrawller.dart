import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PuppeteerUtil.dart';
import 'package:sumgo_crawller_flutter/_local/local.dart';
import 'package:puppeteer/puppeteer.dart';

class MyCrawller {
  final p = PuppeteerUtil();
  final delay = Duration(milliseconds: 100);
  final timeout = Duration(seconds: 20);
  final List<String> listToIncludeAlways = const ["flutter"];
  final List<String> listToInclude = const ["앱 개발", "취미/자기개발"];
  final List<String> listToExclude = const ["초등학생", "중학생"];

  Future<void> start() async {
    await p.openBrowser(
      () async {
        await _login(localData["id"], localData["pw"]);
        await _deleteAndSendRequests();
      },
      width: 1280,
      height: 1024,
      isConnect: false,
      headless: true,
    );
  }

  Future<void> _login(String id, String pw) async {
    for (int i = 0; i < 5; i++) {
      await p.goto('https://soomgo.com/requests/received');
      if (await _isLoginSuccess()) {
        LogUtil.info("로그인 성공");
        break;
      }

      LogUtil.info("로그인 필요함");
      await p.type('[name="email"]', id, delay: delay);
      await p.type('[name="password"]', pw, delay: delay);
      await p.clickAndWaitForNavigation('.btn.btn-login.btn-primary',
          timeout: timeout);
    }
  }

  Future<bool> _isLoginSuccess() async {
    bool isLoginPage = await p.existTag(".login-page");
    return !isLoginPage;
  }
  Future<void> _deleteRequest(ElementHandle tag)async {
    await p.click('.quote-btn.del', tag: tag);
    await p.click('.swal2-confirm.btn');

  }

  Future<void> _sendRequests(ElementHandle tag) async {
    //요청보러들어가기
    await tag.click();
    await p.waitForNavigation();

    //불러오기
    await p.click('.quote-tmpl-icon.arrow');
    await p.click('.item-list .item-short:nth-child(1)');
    await p.click('.action-btn-wrap');
    await p.click('.swal2-confirm.btn');

    //견적보내기
    await p.waitForSelector('.file-wrap .delete');
    await p.evaluate(
        "document.querySelector('.btn.btn-primary.btn-block').click();");
  }

  Future<void> _deleteAndSendRequests() async {
    LogUtil.info("_deleteAndSendRequests 시작");

    Future<bool> refreshAndExitIfShould() async {
      await p.goto('https://soomgo.com/requests/received');
      await p.reload();
      await p.autoScroll();
      bool existSelector =
          await p.waitForSelector('.request-list > li > .request-item');
      if (!existSelector) {
        return true;
      }
      return false;
    }

    Future<List<ElementHandle>> getTagList() async =>
        await p.$$('.request-list > li > .request-item');

    while(true) {
      if (await refreshAndExitIfShould()) return;
      List<ElementHandle> tagList = await getTagList();
      if(tagList.isEmpty) break;

      for (var tag in tagList) {
        var messageTag = await p.$('.quote > span.message', tag: tag);
        String message = await p.html(tag: messageTag);

        if (_isValidRequest(message)) {
          await _sendRequests(tag);
          continue;
        }
        else {
          await _deleteRequest(tag);
        }
      }
    }
  }

  bool _isValidRequest(String message) {
    bool isValid = true;
    //이 키워드가 없으면, !isValid
    for (String toInclude in listToInclude) {
      if (!message.contains(toInclude)) {
        isValid = false;
        break;
      }
    }
    //이 키워드가 있으면, !isValid
    for (String toExclude in listToExclude) {
      if (message.contains(toExclude)) {
        isValid = false;
        break;
      }
    }
    //이 키워드가 있으면, 무조건 isValid
    for (String toIncludeAlways in listToIncludeAlways) {
      if (message.toLowerCase().contains(toIncludeAlways.toLowerCase())) {
        isValid = true;
        break;
      }
    }

    return isValid;
  }

}
