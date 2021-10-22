import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:xui/compontent/js/log_util.dart';

class UniLinks {
  UniLinks();

  /// 实例类
  static UniLinks? _instance;
  static get instance => _instance;

  factory UniLinks.init() {
    if (_instance == null) {
      _instance = new UniLinks();
    }
    return _instance!.._init();
  }
  StreamSubscription? _sub;
  Function? jump;
  _init() async {
    print("_init");
    _sub?.cancel();
    _sub = uriLinkStream.listen((Uri? uri) {
      Map<String, String> queryParams = uri!.queryParameters;
      Log.d(queryParams, 'queryParams');
      jump?.call(queryParams);
      // Use the uri and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
    return instance;
    // try {
    //   final initialLink = await getInitialUri();
    //   // Parse the link and warn the user, if it is not correct,
    //   // but keep in mind it could be `null`.
    // } on PlatformException {
    //   // Handle exception by warning the user their action did not succeed
    //   // return?
    // }
  }
}
