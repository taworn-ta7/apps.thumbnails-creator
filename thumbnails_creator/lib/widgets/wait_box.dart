import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';

/// Shows progress dialog box while running long time task.
class WaitBox {
  static Future<T> show<T>(
    BuildContext context,
    Future<T> Function() task,
  ) async {
    final navigator = Navigator.of(context);

    // opens progress dialog box
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Text(t.waitBox.message),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );

    // does task
    final result = await task();

    // dismisses the progress dialog box
    navigator.pop();
    return result;
  }
}
