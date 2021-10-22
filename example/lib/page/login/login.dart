import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:xui/compontent/index.dart';
import 'package:xui_example/common/Icon_path.dart';

import '../../routes_config.dart';
import 'model/login_model_data_entity.dart';
import 'model/login_model_entity.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  Future<bool> _onBackPressed() async {
    return await XAlert(context).showCenterTipsAlter(
      title: '提示',
      info: '确定退出程序吗！',
      callback: () async {
        SystemNavigator.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Center(
        child: Column(
          children: [
            Text(
              '环湖观光车运营系统',
              style: font(32, color: '#3399FF', weight: FontWeight.w600),
            ),
            SizedBox(height: 60.w),
            XInput(
              controller: nameController,
              labelWidget: iconAccount,
              contentPadding: EdgeInsets.only(top: 10.w, bottom: 10.w),
              keyboardType: TextInputType.visiblePassword,
              labelWidth: 50.w,
              hintText: '请输入账号',
              validator: FormKeyEnum.name,
              border: HexToColor('#D9D9D9'),
              // required: true,
              onChanged: (v) {

                print(v);
              },
            ),
            SizedBox(height: 24.w),
            XInput(
              controller: passwordController,
              labelWidget: iconPassword,
              keyboardType: TextInputType.visiblePassword,
              contentPadding: EdgeInsets.only(top: 10.w, bottom: 10.w),
              obscureText: true,
              labelWidth: 50.w,
              hintText: '请输入密码',
              validator: FormKeyEnum.name,
              border: HexToColor('#D9D9D9'),
              // required: true,
              onChanged: (v) {
                print(v);
              },
            ),
            SizedBox(height: 24.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                XCheckBox(
                  right: Text(
                    '记住账户',
                    style: font(14, color: '#000000', weight: FontWeight.w400),
                  ),
                  value: value,
                  activeColor: '#3399FF',
                  onChanged: (v) {
                    setState(() {
                      value = v!;
                    });
                  },
                ),
              ],
            ),
            XButton(
              '登录',
              width: 368.w,
              vertical: 6.w,
              // height: 60.w,
              style: font(16, color: '#ffffff', weight: FontWeight.w400),
              color: HexToColor('#3399FF'),
              callback: () async {
                  Routers.pushNamed(Routes.home);
              },
            ).margin(top: 20.w)
          ],
        ).paddingAll(20.w).background(width: 400.w, height: 400.w),
      ).background(color: Colors.white, radius: 25.w).padding(top: 58.w, bottom: 58.w, left: 74.w, right: 74.w).background(bgImage: IconPath.login_bg, fitBgImage: BoxFit.fill),
    );
  }
}
