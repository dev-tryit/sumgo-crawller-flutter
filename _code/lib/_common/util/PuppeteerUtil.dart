import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:puppeteer/puppeteer.dart';

class PuppeteerUtil {
  late Browser browser;
  late Page tab;

  final defaultTimeout = Duration(seconds: 10);

  //TODO: 안드로이드 에뮬레이터의 경우에, 다른 컴퓨터에 켜져있는 pupueteer를 이용할 수 있다.

  Future<void> openBrowser(Future<void> Function() function,
      {int width = 1280, int height = 1024, bool headless = true}) async {
    //openpackage_info
    browser = await puppeteer.launch(
      headless: headless,
      args: [
        '--no-sandbox',
        '--window-size=$width,$height',
      ],
      defaultViewport: DeviceViewport(
        width: width,
        height: height,
      ),
    );
    tab = await browser.newPage();
    tab.defaultTimeout = defaultTimeout;

    //process
    await function();

    //close
    try {
      await tab.close();
      await browser.close();
    } catch (e) {}
  }

  Future<void> goto(String url) async {
    await tab.goto(url, wait: Until.networkIdle, timeout: defaultTimeout);
  }

  Future<String> html({ElementHandle? tag}) async {
    if (tag == null) {
      return await tab.content ?? "";
    } else {
      return await evaluate(r'el => el.textContent', args: [tag]);
    }
  }

  Future<dynamic> evaluate(String pageFunction, {List? args}) async {
    return await tab.evaluate(pageFunction, args: args);
  }

  Future<void> type(String selector, String content, {Duration? delay}) async {
    await tab.type(selector, content, delay: delay);
  }

  Future<bool> existTag(String selector) async {
    return await evaluate("Boolean(document.querySelector('$selector'))");
  }

  Future<void> wait(double millseconds) async {
    await evaluate('''async () => {
      await new Promise(function(resolve) { 
            setTimeout(resolve, $millseconds)
      });
  }''');
  }

  Future<ElementHandle> $(String selector, {ElementHandle? tag}) async {
    // querySelector를 나타냄.
    if (tag != null) {
      return await tag.$(selector);
    } else {
      return await tab.$(selector);
    }
  }

  Future<List<ElementHandle>> $$(String selector, {ElementHandle? tag}) async {
    // querySelectorAll를 나타냄.
    if (tag != null) {
      return await tag.$$(selector);
    } else {
      return await tab.$$(selector);
    }
  }

  Future<bool> waitForSelector(String selector,
      {bool? visible,
      bool? hidden,
      Duration timeout = const Duration(seconds: 5)}) async {
    try {
      await tab.waitForSelector(selector,
          visible: visible, hidden: hidden, timeout: timeout);
      return true;
    } catch (e) {
      LogUtil.info("$selector 가 없습니다.");
      return false;
    }
  }

  Future<void> click(String selector, {ElementHandle? tag}) async {
    try {
      if (tag == null) {
        await waitForSelector(selector);
      }
      var tagToClick = await $(selector, tag: tag);
      await tagToClick.click();
    } catch (e) {}
  }

  Future<Response?> clickAndWaitForNavigation(String selector,
      {Duration? timeout, Until? wait}) async {
    try {
      return await tab.clickAndWaitForNavigation(selector,
          timeout: timeout, wait: wait);
    } catch (e) {
      return null;
    }
  }

  Future<bool> include(String selector, String text) async {
    return await evaluate(
        "(document.querySelector('$selector')?.innerText ?? '').includes('$text')");
  }

  Future<void> autoScroll() async {
    await evaluate('''async () => {
        await new Promise((resolve, reject) => {
            var totalHeight = 0;
            var distance = 100;
            var timer = setInterval(() => {
                var scrollHeight = document.body.scrollHeight;
                window.scrollBy(0, distance);
                totalHeight += distance;

                if(totalHeight >= scrollHeight){
                    clearInterval(timer);
                    resolve();
                }
            }, 100);
        });
    }''');
  }
}
