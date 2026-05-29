import 'dart:io';
import 'package:flutter/foundation.dart';

class AdmobConfig {
  // Офіційні тестові ID від Google — завжди безпечно використовувати в розробці
  static const _testBannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const _testBanneriOS = 'ca-app-pub-3940256099942544/2934735716';

  // Production ID — замінити після реєстрації на admob.google.com
  static const _prodBannerAndroid = 'YOUR_ANDROID_BANNER_AD_UNIT_ID';
  static const _prodBanneriOS = 'YOUR_IOS_BANNER_AD_UNIT_ID';

  static String get bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isIOS ? _testBanneriOS : _testBannerAndroid;
    }
    return Platform.isIOS ? _prodBanneriOS : _prodBannerAndroid;
  }
}
