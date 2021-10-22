# xui

正在不断完善中。。。对前端转app端的同学可能比较友好！

## Getting Started

主要包含项目中常用的html元素，项目布局和js方法,可作为项目模板使用

进入页面先设置下尺寸
````dart
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
````
 

## html 部分

####  布局:
````dart
    SizedBox()
    .margin(10.w) 
    .paddingAll(20.w)
    .background(color: Colors.white, width: 1216.w, height: 672.w, radius: 12.w)
   // background  来设置块装的背景，长宽，圆角，边框颜色宽度; 不可以直接设置在Container ，可以先包一个SizedBox
````
#### XButton 按钮:
````dart
    XButton(
        '扫码收款',
        style: font(14, color: '#333333', weight: FontWeight.w400),
        color: HexToColor('#F0F2F5'),
        borderColor: HexToColor('#D7DBE0'),
        radius: 3.w,
        height: 58.w,
        horizontal: 20.w,
        params: {},
        api: params.submit,
        callback: (v) {
            // params: params.toJson(),
            // api: params.submit,
        },
    ),

````

#### XCheckBox 复选框:
````dart
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

````
#### XRadio 单选框:
````dart
     XRadio(
        data: data,
        type: radio.row,
        callback: (v) { },
    ),
````

#### XDivision 分割线:
````dart
    XDivision(height: 1.w)
````

#### XImage 图片:
````dart
   XImage(image: 'img', width: 64.w, height: 64.w),
````

#### XInput 输入框:
````dart
  XInput(
        controller: nameController,
        keyboardType: TextInputType.visiblePassword,
        labelWidth: 0.w,
        hintText: '请输入编号',
        border: ThemeColor.border,
        radius: 4.w,
        onChanged: (v) {
            print(v);
        },
    ).background(width: 200.w, height: 37.w),
````


#### XSelectInput 选择框:
````dart
  XSelectInput(
    width: 200.w,
    initialValue: _data,
    onSelected: (c) {
        print(c);
    },
    list: data,
)),
````


#### XP 多个text拼接:
````dart
  XP([
    {
    'title': '预计',
    'style': font(16, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w400),
    },
    {
    'title': ' 0 ',
    'style': font(16, color: '#FF6A09', weight: FontWeight.w400),
    },
    {
    'title': '人下车',
    'style': font(16, colorA: Color.fromRGBO(0, 0, 0, 0.85), weight: FontWeight.w400),
    }
]),
````

#### XForm 表单布局:
````dart
 List list = [
      {
        'name': '上车站点',
        'value': '上车站点1111',
      },
      {
        'name': '下车站点',
        'child': () => _stationListData == null
            ? Container()
            : Text('下车站点'),
      },
      {
        'name': '单价',
        'value': '￥${params.price}',
      },
      {
        'name': '数量',
         'hidden':true,
        'child': () => XComputer(
              num: params.totalTicketCount,
              onValueChanged: (int value) {
                params.totalTicketCount = value;
                setState(() {});
              },
            )
      },
    ];


    XForm(
        child: (item, inline) => XFormItem(
                label: item['name'],
                value: item['value'],
                hidden: item['hidden'],
                align: (item['name'] == '下车站点' || item['name'] == '票型') ? CrossAxisAlignment.start : null,
                child: item.containsKey('child') ? item['child']() : null,
            ).margin(top: 16.w),
        list: list)

````


#### XTable 表单:
````dart

    receptionTicketOrderList = _ticketOrderList!
          .map((e) => {
                'orderNo': e.ticketOrderNumber,
                'type': ticketsEnumString(TicketsEnum.values[e.ticketType ?? 0]),
                'onUpSite': '${e.startStationName}-${e.endStationName}',
                'people': e.totalTicketCount,
                'price': e.totalAmount,
                'orderTime': e.createTime,
                'orderState': paymentStatusEnumString(PaymentStatusEnum.values[int.parse((e.paymentStatus ?? '0')) + 1]),
                'orderFrom': orderSourceEnumString(OrderSourceEnum.values[(e.orderSource ?? 1) - 1]),
                'businessState': businessTypeEnumString(BusinessTypeEnum.values[(e.businessType ?? 1) - 1]),
                'payWay': paymentTypeEnumString(e.paymentType),
                'id': e.id,
              })
          .toList();

    tableColumn = [
        TableColumn(prop: 'orderNo', label: '订单编号', width: 260.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'type', label: '票型', width: 100.w),
        TableColumn(prop: 'onUpSite', label: '上下车站点', width: 200.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'people', label: '人数', width: 40.w),
        TableColumn(prop: 'price', label: '金额', width: 100.w),
        TableColumn(prop: 'orderTime', label: '订单时间', width: 200.w, alignment: Alignment.centerLeft),
        TableColumn(prop: 'orderState', label: '订单状态', width: 100.w),
        TableColumn(prop: 'orderFrom', label: '订单来源', width: 100.w),
        TableColumn(prop: 'businessState', label: '业务状态', width: 100.w),
        TableColumn(prop: 'payWay', label: '支付方式', width: 100.w),
        TableColumn(
            prop: 'btn',
            label: '操作',
            maxLines: 3,
            widget: (i) => XButton('详情', style: font(14, color: '#3399FF', weight: FontWeight.w400), callback: () async {
                    OrderDetailGetData model = await HomeApi.ticketOrderGet({'id': _search.receptionTicketOrderList[i]['id']});
                    Alert(context).orderDetail(
                    model: model,
                    title: '订单详情',
                    callback: (v) {},
                    );
                }))
    ];
  XTable(
    data: receptionTicketOrderList,
    onRefresh: () =>onRefresh(),
    tableColumn: tableColumn!,
    config: TableConfig()
        ..style = font(14, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w400)
        ..headerStyle = font(14, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w500),
    )
````


#### XPaginatedTable 分页:
````dart
  XPaginatedTable(
    pageIndexKey: 'pageIndex',
    pageSizeKey: 'pageSize',
    totalNum:  HomeApi.model.ticketOrderListData?.total,
    params: _search.toJson(),
    api: _search.submit,
    onChange: (data, pageIndex) {
        _search.pageIndex = pageIndex;
        setState(() {});
    })
````


##  js 部分



#### 验证表单填写信息:
````dart
  List<CheckFormItem> arr = [
      CheckFormItem()
        ..required = true
        ..key = FormKeyEnum.name
        ..value = params.loginName,
      CheckFormItem()
        ..required = true
        ..key = FormKeyEnum.empty
        ..info = "请输入密码"
        ..value = params.password,
    ];
    if (!checkAllForm(arr)) return ajax();
````

#### 未完~等待更新！！！:

# xui-2.0.7
