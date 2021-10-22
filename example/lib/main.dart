import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xui/compontent/index.dart';
import 'package:xui/compontent/js/screem.dart';
import 'package:xui_example/routes_config.dart';
import 'package:xui_example/sdk_config.dart';

import 'api/Api.dart';
import 'utils/uniLink.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sdkConfig();
    WidgetsBinding.instance!.addObserver(this);
    UniLinks.init().jump = (Map v) {
      if (v.containsKey('host')) {
        Api.proxyIp = v['host'];
      }
    };
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("-didChangeAppLifecycleState-" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: '模板',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routers.initialRoute.toString(),
      builder: (context, child) {
        ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: HexToColor('#F7F8FA'),
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: child,
            ),
          ),
        );
      },
      onGenerateRoute: Routers.getRoutes,
    );
  }
}
