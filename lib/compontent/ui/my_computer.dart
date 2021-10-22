import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../js/color_utils.dart';
import 'icon.dart';
import 'my_toast.dart';
import '../index.dart';

// ignore: must_be_immutable
class XComputer extends StatefulWidget {
  int min;
  int max;
  double height;
  int num;
  ValueChanged<int> onValueChanged;
  double? size;
  double? radius;
  bool disabled;
  XComputer({Key? key, this.height = 36.0, this.size, this.num = 0, this.min = 1,this.disabled = false, this.radius, this.max = 1000000000000, required this.onValueChanged}) : super(key: key);

  @override
  _XComputerState createState() {
    return _XComputerState();
  }
}

class _XComputerState extends State<XComputer> {
  int get min => widget.disabled? widget.num : widget.min;
  int get max => widget.disabled ? widget.num : widget.max;
  int get num => widget.num;
 
  double? get size => widget.size;
  double? get radius => widget.radius ?? 4.w;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _minusNum,
            child: IconRemove(num == min, size).background(
              alignment: Alignment.center,
              radius: radius,
            ),
          ),
          Container(
            width: 40.0,
            alignment: Alignment.center,
            child: Text(
              widget.num.toString(),
              maxLines: 1,
              style: TextStyle(fontSize: 16.0, color: HexToColor('#3E3E3E')),
            ),
          ),
          GestureDetector(
            onTap: _addNum,
            child: IconAdd(num == max, size).background(
              alignment: Alignment.center,
              radius: radius,
            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    if (widget.num == min) {
      showToast(context, '不可小于最小数量');
      return;
    }

    setState(() {
      widget.num -= 1;
      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }

  void _addNum() {
    if (widget.num == max) {
      showToast(context, '不可大于最大数量');
      return;
    }
    setState(() {
      widget.num += 1;
      widget.onValueChanged(widget.num);
    });
  }
}

// ignore: non_constant_identifier_names
Widget IconAdd(b, [size]) {
  Color color = !b ? HexToColor('#3399FF') : HexToColor('#CCCCCC');
  Color colorBg = !b ? Color.fromRGBO(51, 153, 255, 0.06) : HexToColor('#F6F6F6');
  return Center(
    child: Icon(
      Icons.add,
      size: 16,
      color: color,
    ),
  ).background(width: size ?? 32.w, height: size ?? 32.w, color: colorBg, radius: 1.w);
}

// ignore: non_constant_identifier_names
Widget IconRemove(b, [size]) {
  Color color = !b ? HexToColor('#3399FF') : HexToColor('#CCCCCC');
  Color colorBg = !b ? Color.fromRGBO(51, 153, 255, 0.06) : HexToColor('#F6F6F6');

  return Center(
    child: Icon(
      Icons.remove,
      size: 16,
      color: color,
    ),
  ).background(width: size ?? 32.w, height: size ?? 32.w, color: colorBg, radius: 1.w);
}
