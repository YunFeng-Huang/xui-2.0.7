import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/index.dart';

// ignore: must_be_immutable
class HeaderTitle extends StatelessWidget {
  String title;
  Widget? right;
  HeaderTitle(this.title, {this.right});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: font(20, colorA: Color.fromRGBO(0, 0, 0, 0.85), weight: FontWeight.w500)).centerLeft,
            if (isNotNull(right)) Container(child: right),
          ],
        ),
        XDivision(height: 1.w),
      ],
    );
  }
}
