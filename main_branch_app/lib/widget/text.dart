import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MText extends StatelessWidget {
  String text;
  double size;
  FontWeight fw;
  MText(this.text, this.size,this.fw, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fw,
      ),
    );
  }
}
