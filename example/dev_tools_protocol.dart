import 'package:puppeteer/puppeteer.dart';

main() async {
  var browser = await Browser.start();
  // Create a chrome's tab
  var page = await browser.newPage();

  // You can access the entire Chrome DevTools protocol.
  // This is useful to access information not exposed by the Puppeteer API
  // Be aware that this is a low-level, complex API.
  // Documentation of the protocol: https://chromedevtools.github.io/devtools-protocol/

  // Examples:

  // Access the Animation domain
  await page.devTools.animation.setPlaybackRate(10);

  // Access the CSS domain
  page.devTools.css.onFontsUpdated.listen((_) {});

  // Access the Memory domaina
  await page.devTools.memory.getDOMCounters();

  await browser.close();
}
