import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class XAlert {
  BuildContext context;
  XAlert(this.context);

  /// 底部弹出提示框
  showBottomAlert({required list, callback, title}) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return ShowCustomAlterWidget(callback, list, title);
      },
    );
  }

  /// 中间弹出提示框
  showCenterTipsAlter({required String title, required String info, callback, custom,cancalText,sureText,width,height,bool sureBtn = true,bool cancalBtn  = true}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowTipsAlterWidget(callback, title, info, custom,cancalText,sureText,width,height, sureBtn, cancalBtn);
      },
    );
  }
}

class ShowTipsAlterWidget extends StatefulWidget {
  final callback;
  final title;
  final info;
  Widget? custom;
  String? cancalText;
  String? sureText;
  double? width;
  double? height;
  bool? sureBtn;
  bool? cancalBtn;
  ShowTipsAlterWidget(this.callback, this.title, this.info, this.custom,this.cancalText,this.sureText,this.width,this.height,this.sureBtn ,this.cancalBtn);
  @override
  _ShowTipsAlterWidgetState createState() => _ShowTipsAlterWidgetState();
}

class _ShowTipsAlterWidgetState extends State<ShowTipsAlterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: new Column(
          children: <Widget>[
            _titleView(),
            Expanded(
              child: widget.custom ?? _textView(),
            ),
            Divider(
              height: 1,
              color: Color(0xFFEAEAEA),
            ),
            _buttonView(),
          ],
        ).background(width: widget.width??280.w , height:widget.height??170.w, color: Colors.white, radius: 10.w),
      ),
    );
  }

  Widget _titleView() {
    return Center(
      child: Text(widget.title ?? '提示'),
    ).background(height: 45.w);
  }

  Widget _textView() {
    return Center(
      child: Text(widget.info ?? ''),
    ).margin(bottom: 20.w);
  }

  Widget _buttonView() {
    return new Container(
      height: 50.w,
      child: new Row(
        children: <Widget>[
           if(widget.cancalBtn!) new Expanded(
            child: _getLiftBtn(),
          ),
          new Container(
            width: 1,
            color: ThemeColor.line,
          ),
        if(widget.sureBtn!)  new Expanded(
            child: _getRightBtn(),
          ),
        ],
      ),
    );
  }

  Widget _getLiftBtn() {
    return XButton(
      widget.cancalText?? '取消',
      callback: () => Navigator.pop(context, false),
    ).center;
  }

  Widget _getRightBtn() {
    return XButton(
      widget.sureText??'确定',
      callback: () async {
        var value = await widget.callback?.call();
        if(value==null) Navigator.pop(context, true);
      },
    ).center;
  }
}

class ShowCustomAlterWidget extends StatefulWidget {
  final confirmCallback;
  final list;
  final title;

  const ShowCustomAlterWidget(this.confirmCallback, this.list, this.title);

  @override
  _ShowCustomAlterWidgetState createState() => _ShowCustomAlterWidgetState();
}

class _ShowCustomAlterWidgetState extends State<ShowCustomAlterWidget> {
  final controller = TextEditingController();

  String inputValuue = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: widget.title == null ? null : Text(widget.title),
      actions: List.generate(
        widget.list.length,
        (index) => CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            widget.confirmCallback(index);
          },
          child: Text(widget.list[index]),
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('取消'),
      ),
    );
  }
}

class ShowInputAlertWidget extends StatefulWidget {
  final callback;
  final title;
  final placeholder;
  const ShowInputAlertWidget(this.callback, this.title, this.placeholder);

  @override
  _ShowInputAlertWidgetState createState() => _ShowInputAlertWidgetState();
}

class _ShowInputAlertWidgetState extends State<ShowInputAlertWidget> {
  String inputValue = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Column(
        children: <Widget>[
          CupertinoTextField(
            placeholder: widget.placeholder,
            onChanged: (value) {
              inputValue = value;
            },
          )
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
            widget.callback(null);
          },
        ),
        CupertinoDialogAction(
          child: Text("确定"),
          onPressed: () {
            widget.callback(inputValue);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
