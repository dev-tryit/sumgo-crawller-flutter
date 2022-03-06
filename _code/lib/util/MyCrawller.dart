import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/PuppeteerUtil.dart';
import 'package:kdh_homepage/_local/local.dart';
import 'package:puppeteer/puppeteer.dart';

//gitignore 적용 완료
class MyCrawller {
  final p = PuppeteerUtil();
  final delay = Duration(milliseconds: 100);
  final timeout = Duration(seconds: 20);
  final List<String> listToIncludeAlways = const ["flutter"];
  final List<String> listToInclude = const ["앱 개발", "취미/자기개발"];
  final List<String> listToExclude = const ["초등학생", "중학생"];

  void start() async {
    p.openBrowser(
      () async {
        await _login(localData["id"], localData["pw"]);
        await _deleteRequests();
      },
      headless: false,
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

  Future<bool> _checkLoginFail() async {
    return await p.include(".invalid-feedback", "입력해주세요") ||
        await p.include(".form-text.text-invalfid", "입력해주세요");
  }

  Future<void> _deleteRequests() async {
    LogUtil.info("deleteRequests 시작");
    await p.goto('https://soomgo.com/requests/received');

    bool existSelector =
        await p.waitForSelector('.request-list > li > .request-item');
    if (!existSelector) {
      return;
    }

    List<ElementHandle> tagList =
        await p.$$('.request-list > li > .request-item');
    for (var tag in tagList) {
      var messageTag = await p.$('.quote > span.message', tag: tag);
      String message = await p.html(tag: messageTag);

      if (!_isValidRequest(message)) {
        await p.click('.quote-btn.del', tag: tag);
        await p.click('.sv-col-small-button-bw.sv__btn-close');
        // FileUtil.writeFile(
        //     "${DateTimeUtil.now().toIso8601String()}.html", await p.html());
        await p.click('.swal2-confirm.btn');

        LogUtil.info("삭제할 tagText : " + message);
      } else {
        LogUtil.info("내가 좋하하는 tagText : " + message);
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
