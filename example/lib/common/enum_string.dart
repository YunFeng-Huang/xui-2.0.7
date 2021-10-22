import 'package:xui/compontent/js/index.dart';
import 'package:xui/compontent/js/log_util.dart';

enum PaymentStatusEnum { all, stayPay, success, error, stayRefund, hasRefund, errorRefund, partRefund, complete }
enum BusinessTypeEnum { one, two } //one 售票 two 包车
enum PaymentTypeEnum { weixin, alipay, cash }
enum TicketsEnum { all, sudi, huanhu, qujian }
enum OrderSourceEnum { small, scene }
enum notifyType { order, refund, refundResult, billSubmit, billResult }
enum DateTypeEnum { today, yesterday, week, month }
enum TicketListEnum { reception, order } //接待票列表，订单列表
enum RefundStatus { waiting, complete, rejected } //退单状态 1-待处理 2-已处理 3-已驳回

String refundStatusEnumString(RefundStatus v) {
  var map = {
    RefundStatus.waiting: '待处理',
    RefundStatus.complete: '已处理',
    RefundStatus.rejected: '已驳回',
  };
  return map[v] ?? '';
}

notifyTypeEnumString(v) {
  var map;
  if (v.runtimeType == notifyType) {
    map = {
      /** 用户下单通知司机 */
      notifyType.order: '小程序下单通知',
      /** 司机提交退单通知运营后台 */
      notifyType.refund: '司机提交退单通知',
      /** 运营后台审核退单通知司机 */
      notifyType.refundResult: '退票信息',
      /** 司机提交对账通知运营后台 */
      notifyType.billSubmit: '司机提交账单通知',
      /** 运营后台审核对账通知司机 */
      notifyType.billResult: '交账信息',
    };
  } else {
    map = {
      'order': notifyType.order,
      'refund': notifyType.refund,
      'refundResult': notifyType.refundResult,
      'billSubmit': notifyType.billSubmit,
      'billResult': notifyType.billResult,
    };
  }
  return map[v] ?? '';
}

String dateTypeEnumString(DateTypeEnum v) {
  var map = {
    DateTypeEnum.today: '今日',
    DateTypeEnum.yesterday: '昨日',
    DateTypeEnum.week: '本周',
    DateTypeEnum.month: '本月',
  };
  return map[v] ?? '';
}

String businessTypeEnumString(BusinessTypeEnum v) {
  var map = {
    BusinessTypeEnum.one: '售票',
    BusinessTypeEnum.two: '包车',
  };
  return map[v] ?? '';
}

String paymentStatusEnumString(PaymentStatusEnum v) {
  var map = {
    PaymentStatusEnum.all: '全部',
    PaymentStatusEnum.stayPay: '待支付',
    PaymentStatusEnum.success: '支付成功',
    PaymentStatusEnum.error: '支付失败',
    PaymentStatusEnum.stayRefund: '待退款',
    PaymentStatusEnum.hasRefund: '已退款',
    PaymentStatusEnum.errorRefund: '退款失败',
    PaymentStatusEnum.partRefund: '部分退款',
    PaymentStatusEnum.complete: '已完成',
  };
  return map[v] ?? '';
}

String orderSourceEnumString(OrderSourceEnum v) {
  var map = {
    OrderSourceEnum.small: '小程序',
    OrderSourceEnum.scene: '现场售票',
  };
  return map[v] ?? '';
}

String paymentTypeEnumString(v) {
  var map;
  if (v.runtimeType == PaymentTypeEnum) {
    map = {
      PaymentTypeEnum.weixin: '微信',
      PaymentTypeEnum.alipay: '支付宝',
      PaymentTypeEnum.cash: '现金',
    };
  } else {
    map = {
      'weixin': '微信',
      'alipay': '支付宝',
      'cash': '现金',
    };
  }

  return map[v] ?? '';
}

String ticketsEnumString(TicketsEnum v) {
  var map = {
    TicketsEnum.all: '全部',
    TicketsEnum.sudi: '苏堤票',
    TicketsEnum.huanhu: '环湖票',
    TicketsEnum.qujian: '区间票',
  };
  return map[v] ?? '';
}
