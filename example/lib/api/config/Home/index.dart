import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../Api.dart';
import 'url.dart';

class ApiModel {}

class HomeApi {
  static ApiModel model = new ApiModel();
  static BuildContext? get _context => navigatorKey.currentState?.context;

  static Future weatherInfo(Map<String, dynamic> queryParameters) async {
    Response response = await Api.request(URl.weatherInfo, queryParameters: queryParameters).catchError((onError) {
      return null;
    });
    return response;
  }

  static Future driverLogin(params) async {
    Options setOption = Options()..headers = {'bbb': true};
    var response = await Api.request(URl.driverLogin,
            data: params,
            queryParameters: {
              'queryParameters': 111,
            },
            setOption: setOption)
        .catchError((onError) {
      return null;
    });
    return response;
  }

// static Future uploadBigFile() async {
  //   await XupLoadFile.getVideo(ImageSource.gallery);
  //   String token = await getToken();
  //
  //   var previewLink = await XupLoadFile.upload(
  //     type: 'video',
  //     url: Config.baseUrl + URl.uploadBigFile,
  //     token: token,
  //     merchantId: Config.merchantId,
  //   );
  //   print(previewLink);
  //   // var response = await Api.putBigFile(URl.uploadBigFile, filePath);
  //   // var previewLink = jsonDecode(response)['previewLink'];
  //   return previewLink;
  // }
}

//eg
// static Future queryTitle(Map<String, dynamic> params) async {
//   Options setOption = Options()..headers = {'needToken': true};
//   var response = await Api.request(URl.queryTitle,
//           data: params,
//           queryParameters: {
//             'queryParameters': 111,
//           },
//           setOption: setOption)
//       .catchError((onError) {
//     return null;
//   });
//   return response;
// }
