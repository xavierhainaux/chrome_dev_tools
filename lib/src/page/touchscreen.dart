import 'dart:math';

import 'package:chrome_dev_tools/domains/input.dart';
import 'package:chrome_dev_tools/domains/runtime.dart';

class Touchscreen {
  final RuntimeApi runtimeApi;
  final InputApi inputApi;
  final keyboard;

  Touchscreen(this.runtimeApi, this.inputApi, this.keyboard);

  Future<void> tap(Point position) async {
    // Touches appear to be lost during the first frame after navigation.
    // This waits a frame before sending the tap.
    // @see https://crbug.com/613219
    await runtimeApi.evaluate(
        'new Promise(x => requestAnimationFrame(() => requestAnimationFrame(x)))',
        awaitPromise: true);

    await inputApi.dispatchTouchEvent('touchStart',
        [TouchPoint(x: position.x.round(), y: position.y.round())],
        modifiers: keyboard.modifiers);
    await inputApi.dispatchTouchEvent('touchEnd', [],
        modifiers: keyboard.modifiers);
  }
}