class Config {
  static get version => '1.0.0';   //版本号
  static final isDev = false; //  是否是开发环境
  static final isProd = false; // true 上线 / false 测试
  //10000241 10000258
  static final merchantId = null;
  static get grayVersion => isDev ? '' : ''; //灰度s
  static get baseUrl => isDev ? 'https://dev-huanhu.iuctrip.com/' : prodUrl;
  static final prodUrl = isProd
      ? 'https://fat-huanhu.iuctrip.com/'
      : "https://fat-huanhu.iuctrip.com/";

  //oss
  static const OssBaseUrl = 'https://oss.iuctrip.com/';
  //服务
  static const String DestinationAppletService = 'destination-applet-service';
  static const String MemberService = 'member-service';
  static const String MerchantService = 'merchant-service';
  static const String NoticeService = 'notice-service';
  static const String SkinService = 'skin-service';
  static const String RateService = 'rate-service';

}
