import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:xui/compontent/index.dart';
import 'package:xui_example/api/Api.dart';
import 'package:xui_example/common/Icon_path.dart';
import '../routes_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late List list = [
    _bottomIcon('日常运营', IconPath.home_Bg_4, '#FFA43B', Routes.login),
    _bottomIcon('订单管理', IconPath.home_Bg_1, '#A2DF7D', Routes.login),
    _bottomIcon('运营数据', IconPath.home_Bg_2, '#37CEFF', Routes.login),
    _bottomIcon('交账', IconPath.home_Bg_3, '#FF3DD6', Routes.login),
  ];
  var str = "";
  // var str = "公告内容 1：今日环湖小程序正式启用西湖南、西、北三面环山，东邻城区，南部和钱塘江隔山相邻，湖中白堤、苏堤、杨公堤、赵公堤将湖面分割成若干。2：湖中有三岛，西湖群山以西湖为中心，由近及远可分为四个层次，海拔高度从50至400米依次抬升，形成“重重叠叠山”的地貌景观。西湖与群山的第一层次相连，与后三个层次的距离，分别为1650米、3450米和5600米，在湖中看山景，仰角在5°以内 3：西湖汇水面积为21.22平方千米，流域内年径流量为1400万立方米，蓄水量近1400万立方米，水的自然交替为1次/年。西湖的湖体轮廓呈近椭圆形，湖底部较为平坦。湖泊天然地表水源是金沙涧、龙泓涧、赤山涧（慧因涧）、长桥溪四条溪流。湖泊水位保持在黄海标高7.15米，±0.05米，最高水位7.70米，最低水位6.92米，高低相差50厘米。库容量约1429.4万立方米。4：西湖景区内共有鸟类119种，哺乳类动物20余种。西湖水面就有水鸟38种。丁家山、乌龟山等是鹭鸟的栖息地，鹭鸟数目在两万只以上。";
  bool noComments = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api.context = context;
    _init();
  }

  void _init() async {
    String? token = await getToken();
    if (!isNotNull(token) ) {
      Routers.pushNamed(Routes.login, callback: (v) {
      });
    } else {
      // JPushUtil.init();
    }
  }


  @override
  Widget build(BuildContext context) {
    return _buildXCustomScrollView(context);
  }

  Future<bool> _onBackPressed() async {
    return await XAlert(context).showCenterTipsAlter(
      title: '提示',
      info: '确定退出程序吗！',
    );
  }

  Widget _buildXCustomScrollView(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '运营公告',
                  style: font(20, color: '#595959'),
                ),
                SizedBox(height: 16.w),
                Expanded(
                  child: (noComments
                          ? SingleChildScrollView(
                              child: Text('str'),
                            )
                          : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  XImage(image: IconPath.no_comments),
                                  SizedBox(height: 10.w),
                                  Text(
                                    '暂无公告',
                                    style: font(14,
                                        color: '#98A7BF',
                                        weight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ))
                      .paddingAll(20.w)
                      .background(
                        color: Colors.white,
                        radius: 16.w,
                        width: 1216.w,
                      ),
                ),
              ],
            ).margin(left: 40.w, right: 40.w, top: 40.w),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              list.length,
              (index) => GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    XImage(image: list[index].img, width: 64.w, height: 64.w),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].title,
                          style: font(24.w, color: '#595959'),
                        ),
                        SizedBox(height: 10.w),
                        Row().background(
                            width: 42.w,
                            height: 2.w,
                            radius: 2.w,
                            color: HexToColor(list[index].color)),
                      ],
                    )
                  ],
                ).background(
                    width: 266.w,
                    height: 266.w,
                    radius: 16.w,
                    color: Colors.white),
                onTap: () async {
                  
                },
              ),
            ),
          ).marginAll(40.w)
        ],
      ),
    );
  }
}

class _bottomIcon {
  String? title;
  String? img;
  String? color;
  Routes? route;
  _bottomIcon(this.title, this.img, this.color, this.route);
}
