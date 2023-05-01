import 'package:flutter/foundation.dart';

extension ShowString on String {
  String debugMode() {
    if (kDebugMode) {
      return this;
    } else {
      return '';
    }
  }
}
