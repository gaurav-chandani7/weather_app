import 'dart:developer';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Future<void> showLoading() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const Material(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      if (Navigator.canPop(this)) {
        Navigator.pop(this);
      }
    } catch (_) {
      log(_.toString());
    }
  }

  void pushReplacementNamed(String routeName, {Object? args}) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  void pushNamed(String routeName, {Object? args}) {
    Navigator.of(this).pushNamed(routeName);
  }

  void push(Widget widget) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => widget));
  }
}
