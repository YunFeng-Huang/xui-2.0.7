import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../css.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XButton extends StatefulWidget {
  TextStyle? style;
  String? text;
  double? width;
  double? height;
  double? horizontal;
  double? vertical;
  double? borderSize;
  Color? borderColor;
  Color? color;
  double? radius;
  Map? params;
  Function? paramsFn;
  Function? api;
  Function? callback;
  bool disabled;
  XButtonType? type;
  XButton(this.text, {this.style, this.type, this.width, this.height, this.paramsFn, this.borderSize, this.borderColor, this.radius, this.vertical, this.horizontal, this.disabled = false, this.params, this.api, required this.callback, this.color}) {
    type = type ?? XButtonType.btn;
  }
  @override
  _XButtonState createState() => _XButtonState();
}

class _XButtonState extends State<XButton> {
  TextStyle? get style => widget.style;
  String? get text => widget.text;
  double? get radius => widget.radius ?? 10.w;
  double? get width => widget.width;
  double? get height => widget.height;
  double? get horizontal => widget.horizontal;
  double? get vertical => widget.vertical;
  double? get borderSize => widget.borderSize;
  Color? get borderColor => widget.borderColor;
  Function? get api => widget.api;
  Function? get callback => widget.callback;
  Color? get color => widget.color;
  Map? get params => isNotNull(widget.paramsFn) ? widget.paramsFn?.call() : widget.params;
  bool _disabled = false;
  void onPressed() async {
    if (api != null) {
      setState(() {
        _disabled = true;
      });
      if (params != null) {
        var data = await api?.call(params);
        Log.d(data, 'data');
        await callback?.call(data);
      }

      setState(() {
        _disabled = false;
      });
    } else {
      callback?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool disabled = _disabled || widget.disabled;
    bool _type = widget.type == XButtonType.btn;
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Center(
        child: Text(
          text ?? '',
          style: !_type && disabled ? TextStyle(color: ThemeColor.disable) : style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ).padding(horizontal: horizontal, vertical: vertical),
      ).background(color: disabled && _type ? ThemeColor.disable : color, border: borderSize, borderColor: borderColor, width: width, height: height, radius: radius),
    );
  }
}

enum XButtonType { btn, text }
// Widget button(title, onTap, {minWidth, width, height, color, fontStyle, disable = false, disableText, borderRadius}) {
//   return SizedBox(
//     width: width,
//     height: height,
//     child: TextButton(
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       color: color ?? HexToColor(ThemeColor.active),
//       // highlightColor: Colors.blue[700],
//       colorBrightness: Brightness.dark,
//       splashColor: Colors.grey,
//       disabledColor: HexToColor(ThemeColor.disable),
//       child: Text(disable ? disableText ?? title : title, style: fontStyle),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
//       onPressed: disable ? null : onTap,
//     ),
//   );
// }
