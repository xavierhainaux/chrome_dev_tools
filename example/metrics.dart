import 'package:puppeteer/puppeteer.dart';

void main() async {
  var browser = await puppeteer.launch();
  var page = await browser.newPage();
  await page.goto('https://www.github.com', wait: Until.networkIdle);

  var metrics = await page.metrics();

  print(metrics);

  await browser.close();
}
