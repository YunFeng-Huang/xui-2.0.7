import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui_example/page/home.dart';
import 'package:xui_example/page/login/login.dart';

import 'main.dart';

enum Routes { home, login }

class Routers {
  static BuildContext? get _context => navigatorKey.currentState?.context;
  static Map _routes = {
    Routes.home: (args) => HomePage(), //首页
    Routes.login: (args) => LoginPage(), //登录页
  };
  static Routes initialRoute = Routes.home; //默认首页
  static Routes? currentRoutes;

  static pushNamed(Routes v, {callback, context, arguments}) {
    return Navigator.pushNamed(context ?? _context, v.toString(), arguments: arguments).then((value) => callback?.call(value));
  }

  static pop([context, result]) async {
    return canPop() ? Navigator.pop(context ?? _context, result) : null;
  }

  /// 能否返回 */
  static bool canPop({context}) {
    return Navigator.canPop(context ?? _context);
  }

  /// 替换路由 */
  static void pushReplacementNamed(Routes path, {arguments, context, callback}) {
    Navigator.of(context ?? _context).pushReplacementNamed(path.toString(), arguments: arguments).then((value) {
      callback?.call(value);
    });
  }

  /// 重定向 */
  static void pushNamedAndRemoveUntil(Routes path, Routes path2, {arguments, context, callback}) {
    Navigator.of(context).pushNamedAndRemoveUntil(path.toString(), ModalRoute.withName(path2.toString())).then((value) {
      callback?.call(value);
    });
  }

  /// 路由enum 和string 格式转换 */
  static Map _routersMap() {
    return _routes.map((key, value) => MapEntry(key.toString(), value));
  }

  //动态构建路由
  static Route<dynamic> getRoutes(RouteSettings setting) {
    return _buildRoute(setting, _routersMap()[setting.name](setting.arguments));
  }

  //路由跳转方式
  static MaterialPageRoute _buildRoute(RouteSettings setting, Widget builder) {
    return MaterialPageRoute(
      settings: setting,
      builder: (BuildContext ctx) {
        // ignore: null_check_always_fails
        currentRoutes = Routes.values.firstWhere((type) => type.toString() == setting.name, orElse: () => null!);
        return builder;
      },
    );
  }
}
